//
//  LoginViewModel.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-10-26.
//

import SwiftUI

@MainActor @Observable
class LoginViewModel {

    var email = ""
    var password = ""
    var errorMessage: String?
    var isLoggedIn = false

    func login() async {
        guard let url = URL(string: "http://127.0.0.1:5000/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return }

            if httpResponse.statusCode == 200 {
                let result = try JSONDecoder().decode(LoginResponse.self, from: data)
                KeychainHelper.standard.save(result.token, service: "auth", account: "userToken")
                Log.info("Login successful for \(email)")
                isLoggedIn = true
            } else {
                errorMessage = "Invalid credentials"
            }
        } catch {
            errorMessage = "Network error: \(error.localizedDescription)"
        }
    }
}
