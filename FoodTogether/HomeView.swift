//
//  HomeView.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-10-25.
//

import SwiftUI

struct HomeView: View {

    @State private var isPressed = false
    @State private var viewModel = HomeViewVM()

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack {
                title
                Spacer()
                addButton
                Text("New Group!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .shadow(color: .black.opacity(0.25), radius: 3, y: 2)
                    .scaleEffect(isPressed ? 0.95 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                Spacer()
            }
            .padding(16)
        }
        .task {
            await viewModel.fetchCurrentUserInfo()
        }
    }

    private var title: some View {
        let text: String
        if let message = viewModel.message {
            text = message
        } else {
            text = "Welcome back!"
        }
        return Text(text)
            .foregroundColor(.white)
            .font(.title)
            .bold()
    }

    private var addButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue)
                .frame(width: 80, height: 80)
                .shadow(radius: 5)
            
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .bold))
        }
        .scaleEffect(isPressed ? 0.9 : 1.0) // 👈 adds scale animation
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            print("add button tapped")
            isPressed.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed.toggle()
            }
        }
    }
}

#Preview {
    HomeView()
}
