//
//  CreateAccountView.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-10-26.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var viewModel = CreateAccountViewModel()

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()

            Group {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            }

            Button(action: { viewModel.createAccount() }) {
                Text("Sign Up")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top)
            }

            if let success = viewModel.successMessage {
                Text(success)
                    .foregroundColor(.green)
                    .padding(.top)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    CreateAccountView()
}
