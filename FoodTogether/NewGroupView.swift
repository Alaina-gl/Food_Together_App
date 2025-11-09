//
//  NewGroupView.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-11-08.
//

import SwiftUI

struct NewGroupView: View {
    var body: some View {
        VStack {
            Text("New Group")
                .font(.largeTitle)
                .bold()
            usersList
        }
    }

    private var usersList: some View {
        List {
            Section("Members") {
                Text("Alice")
                Text("Bob")
                Text("Charlie")
            }
        }
    }
}

#Preview {
    NewGroupView()
}
