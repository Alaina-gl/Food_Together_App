//
//  LoginView.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-10-25.
//

import SwiftUI

struct LoginView: View {

    @State private var navigateToHome = false
    @State private var email = ""
    @State private var password = ""

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
                        loginButton
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 50)
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView()
            }
        }
    }

    private var loginButton: some View {
        Button(action: {
            if !email.isEmpty && !password.isEmpty {
                navigateToHome = true
            }
        }) {
            Text("Log In")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal)
    }

    private var headline: some View {
        VStack(spacing: 8) {
            Text("Welcome Back 👋")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            Text("Log in to continue")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
    }

    private var emailPassword: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    LoginView()
}
