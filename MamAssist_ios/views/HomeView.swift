//
//  HomeView.swift
//  MamAssist
//
//  Created by med karim checambou on 19/11/2024.
//
import SwiftUI

struct HomeView: View {

    var body: some View {
        ZStack {
            Image("homepage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                HStack {
                    Text("Welcome")
                        .font(.title2)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 16)

                Spacer()

                // Navigation Bar
                HStack {
                    Spacer()
                    // Navigation items go here
                    createNavBarItem(icon: "house.fill", title: "Home")
                    createNavBarItem(icon: "star.fill", title: "Favorites")
                    createNavBarItem(icon: "bell.fill", title: "Notifications")
                    createNavBarItem(icon: "person.fill", title: "Profile")
                    Spacer()
                }
                .font(.headline)
                .background(Color.blue.opacity(0.1))
                .padding(.bottom, 8)
            }
        }
    }

    private func createNavBarItem(icon: String, title: String) -> some View {
        VStack {
            Image(systemName: icon)
            Text(title)
                .font(.caption)
        }
        .padding()
    }
}
