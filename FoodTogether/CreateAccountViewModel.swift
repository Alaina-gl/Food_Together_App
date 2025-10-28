//
//  CreateAccountViewModel.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-10-26.
//
import SwiftUI
import Foundation

@MainActor @Observable
class CreateAccountViewModel {
    var errorMessage: String?
    var successMessage: String?
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    private let registerURL = URL(string: "http://127.0.0.1:5000/register")!

    func createAccount() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter all fields"
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }

        var request = URLRequest(url: registerURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": email, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)

        Task {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                if httpResponse.statusCode == 200 {
                    successMessage = "Account created successfully"
                    errorMessage = nil
                } else {
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let message = json["message"] as? String {
                        errorMessage = message
                    } else {
                        errorMessage = "Something went wrong"
                    }
                }
            } catch {
                errorMessage = "Network error: \(error.localizedDescription)"
            }
        }
    }
}
