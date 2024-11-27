//
//  loginpage.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 26/11/2024.
//
import SwiftUI

struct Loginpage: View {
    @StateObject private var authViewModel = AuthViewModel() // Declare the authViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create hello")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Welcome to create an account on MamAssist to access our entire content.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Google Sign-In Button
            Button(action: {
                // Handle Google Sign-In logic here
            }) {
                HStack {
                    Image(systemName: "globe") // Placeholder for Google icon
                        .foregroundColor(.white)
                    Text("Sign in with Google")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red) // Google color
                .cornerRadius(8)
            }
            
            // Facebook Login Button
            Button(action: {
                // Handle Facebook Login logic here
                loginWithFacebook()
            }) {
                HStack {
                    Image(systemName: "f.circle.fill") // Placeholder for Facebook icon
                        .foregroundColor(.white)
                    Text("Login with Facebook")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue) // Facebook color
                .cornerRadius(8)
            }

            Text("OR")
                .font(.headline)
                .padding()

            // Email and Password Fields
            VStack(spacing: 10) {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            // Continue Button
            Button(action: {
                // Perform your action here, like navigating or executing a function
                login()
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(8)
            }
            Spacer()
            
            // Back to First Page
            NavigationLink(destination: Firstpage()) {
                Text("Back to First Page")
                    .foregroundColor(.purple)
                    .underline()
            }
            .padding(.bottom)
        }
        .padding()
        .navigationBarBackButtonHidden(true) // Hide the back button
        .navigationBarHidden(true) // Hide the entire navigation bar (optional)
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
    
    private func loginWithFacebook() {
        print("Login with Facebook button tapped")
        // Integrate your Facebook login SDK or custom logic here
    }
}

// Preview for the LoginView
struct LoginView_Previews11: PreviewProvider {
    static var previews: some View {
        Loginpage()
    }
}
