//
//  CreateAccountViewModel.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-10-26.
//
import Foundation
import SwiftUI

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

        let request = makePostRequest(url: registerURL, body: ["email": email, "password": password])

        Task {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                switch httpResponse.statusCode {
                case 201:
                    successMessage = parseResponseMessage(from: data) ?? "Account created successfully"
                    errorMessage = nil

                case 400:
                    errorMessage = parseResponseMessage(from: data) ?? "Something went wrong"
                    successMessage = nil

                default:
                    errorMessage = "Something went wrong"
                    successMessage = nil
                }
            } catch {
                errorMessage = "Network error: \(error.localizedDescription)"
                successMessage = nil
            }
        }
    }

    private func makePostRequest(url: URL, body: [String: String]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        return request
    }

    private func parseResponseMessage(from data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }

        // Try both "message" (success) and "error" (failure)
        if let message = json["message"] as? String {
            return message
        } else if let error = json["error"] as? String {
            return error
        }

        return nil
    }
}
