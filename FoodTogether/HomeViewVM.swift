//
//  HomeViewVM.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-11-08.
//

import SwiftUI

@MainActor @Observable
class HomeViewVM {

    var message: String?

    func fetchCurrentUserInfo() async {
        guard let url = URL(string: "http://127.0.0.1:5000/profile") else { return }

        guard let token = KeychainHelper.standard.read(service: "auth", account: "userToken") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return }

            switch httpResponse.statusCode {
            case 200:
                message = parseResponseMessage(from: data)
            case 404:
                message = "Could not find user"
            default:
                message = "Could not retrive user name"
            }
        } catch {
            
        }
    }

    private func parseResponseMessage(from data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            Log.error("could not parse response meesage into json")
            return nil
        }
        if let message = json["message"] as? String {
            return message
        }
        Log.error("could not parse response meesage into json")
        return nil
    }
}
