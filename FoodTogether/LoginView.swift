//
//  LoginView.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-10-25.
//

import SwiftUI

struct LoginView: View {

    @State private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.7)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 46) {
                        headline
                        emailPassword
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                        }
                        loginButton
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 50)
                }
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                HomeView()
            }
        }
    }

    private var loginButton: some View {
        Button("Login") {
            Task { await viewModel.login() }
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.borderedProminent)
    }

    private var headline: some View {
        VStack(spacing: 8) {
            Text("Welcome Back To FoodTogether 👋")
                .font(.title.bold())
                .foregroundColor(.white)
            Text("Log in to continue")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
    }

    private var emailPassword: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    LoginView()
}
