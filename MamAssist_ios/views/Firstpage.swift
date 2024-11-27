//
//  LoginView.swift
//  MamAssist
//
//  Created by med karim checambou on 19/11/2024.
//
import SwiftUI

struct Firstpage: View {
    var body: some View {
        ZStack {
            Image("firstpage") // Replace with your image name
                .resizable()
                .scaledToFill()
                .ignoresSafeArea() // Extend the image to the edges of the screen
            
            VStack(spacing: 50) {
                Spacer() // Add this spacer to push content down

                // Title or Logo
                Text("hey who are you ?")
                    .font(.largeTitle)
                    .padding(.bottom, 40)

                Spacer() // Add this spacer to push content down

                // "I'm Pregnant" Button
                Button(action: {
                    // Action for each button
                }) {
                    HStack {
                        Image(systemName: "figure.stand.dress") // Placeholder logo, replace with your actual logo image
                            .foregroundColor(.purple)
                        Text("I'm pregnant")
                            .foregroundColor(.purple)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.purple)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.purple, lineWidth: 1)
                    )
                }
                
                // "I Have Children" Button
                Button(action: {
                    // Action for each button
                }) {
                    HStack {
                        Image(systemName: "figure.and.child.holdinghands") // Placeholder logo, replace with your actual logo image
                            .foregroundColor(.purple)
                        Text("I have children")
                            .foregroundColor(.purple)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.purple)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.purple, lineWidth: 1)
                    )
                }

                Spacer() // Add this spacer to push content down
                Spacer() // Add this spacer to push content down

                // Links
                VStack(spacing: 10) {
                    NavigationLink(destination: Loginpage()) {
                        Text("I have an account / Login")
                            .foregroundColor(.purple)
                            .underline()
                    }
                    
                    NavigationLink(destination: HomeView()) {
                        Text("Test app without creating an account")
                            .foregroundColor(.purple)
                            .underline()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 30)
                Spacer() // Add this spacer to push content down
            }
            .padding()
        }
        .navigationBarHidden(true) // Completely hides the navigation bar
        .navigationBarBackButtonHidden(true) // Hides the back button
    }
}

struct Firstpage_Previews: PreviewProvider {
    static var previews: some View {
        Firstpage()
    }
}
