//
//  LoginView.swift
//  MamAssist
//
//  Created by med karim checambou on 19/11/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var authViewModel = AuthViewModel() // Declare the authViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
     @State private var username: String = ""
     @State private var token: String? // Store the token

    var body: some View {
        ZStack {
                        Image("login screen")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()

            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    login() // Call the login function when the button is pressed
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                // Sign In button to navigate to SignInView
                                   NavigationLink(destination: SignupView()) {
                                       Text("Sign In")
                                           .foregroundColor(.blue)
                                           .padding()
                                   }

                // Display login message
                Text(authViewModel.loginMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            .padding()
        }
    }

    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            authViewModel.loginMessage = "Please enter both email and password."
            return
        }

        authViewModel.login(email: email, password: password) { success in
            if success {
                // Handle successful login, e.g., navigate to the main app screen
                print("Login successful!")
                // Navigate to the next screen or update the UI as necessary
            } else {
                // Handle login failure
                print("Login failed: \(self.authViewModel.loginMessage)")
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
