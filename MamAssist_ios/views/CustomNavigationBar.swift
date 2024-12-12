//
//  customnavbar.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 27/11/2024.
//
import SwiftUI

struct CustomNavigationBar: View {
    @Binding var selectedTab: Int // Binding to control the selected tab index

    var body: some View {
        HStack {
            CustomNavBarItem(
                title: "Accueil",
                systemImage: "house.fill",
                isSelected: selectedTab == 0
            ) {
                selectedTab = 0
            }
            Spacer()

            CustomNavBarItem(
                title: "Discussions",
                systemImage: "bubble.left.and.bubble.right.fill",
                isSelected: selectedTab == 1
            ) {
                selectedTab = 1
            }
            Spacer()

            CustomNavBarItem(
                title: "Doctors",
                systemImage: "stethoscope",
                isSelected: selectedTab == 2
            ) {
                selectedTab = 2
            }

            Spacer()

            CustomNavBarItem(
                title: "Tools",
                systemImage: "wrench.and.screwdriver",
                isSelected: selectedTab == 3
            ) {
                selectedTab = 3
            }
        }
        .padding()
        .background(Color.white.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2))
        .navigationBarBackButtonHidden(true)

    }
}

struct CustomNavBarItem: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(isSelected ? .purple : .gray)

                Text(title)
                    .font(.footnote)
                    .foregroundColor(isSelected ? .purple : .gray)
            }
        }
    }
}


