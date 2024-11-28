//
//  Untitled.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 27/11/2024.
//
import SwiftUI

struct ProfileView: View {
    @State private var selectedTab: Int = 2 // Default to Profile tab

    var body: some View {
        VStack(spacing: 0) {
            // Scrollable Content
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header Section
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.purple)

                        Text("John Doe")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.purple)

                        Text("john.doe@example.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 40)

                    // Profile Details Section
                    VStack(spacing: 16) {
                        ProfileRow(title: "Edit Profile", icon: "pencil.circle")
                        ProfileRow(title: "Settings", icon: "gearshape")
                        ProfileRow(title: "Notifications", icon: "bell.circle")
                        ProfileRow(title: "Privacy Policy", icon: "lock.circle")
                        ProfileRow(title: "Log Out", icon: "arrowshape.turn.up.left.circle")
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 80) // Add spacing for the tab bar
            }

                }
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
        
    }
}

// Profile Row for Profile Details
struct ProfileRow: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.purple)

            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.purple)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 18))
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
        )
    }
}


// Custom Tab Bar Button
struct TabBarButton: View {
    let icon: String
    let title: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? .purple : .gray)

            Text(title)
                .font(.caption)
                .foregroundColor(isSelected ? .purple : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
