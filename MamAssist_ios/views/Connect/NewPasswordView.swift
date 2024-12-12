//
//  Untitled.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 11/12/2024.
//
import SwiftUI

struct NewPasswordView: View {
    let email: String // Passed from VerifyCodeView
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isPasswordResetSuccessful = false
    
    var body: some View {
        VStack {
            Text("Set New Password")
                .font(.title)
                .padding(.bottom, 20)
            
            SecureField("New Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                resetPassword()
            }) {
                Text("Reset Password")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            // Navigate back to login after password reset
            NavigationLink(
                destination: LoginViewWithAssetImage(),
                isActive: $isPasswordResetSuccessful
            ) {
                EmptyView()
            }
        }
        .padding()
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func resetPassword() {
        guard let url = URL(string: "http://localhost:3000/auth/change-password") else {
            alertMessage = "Invalid URL."
            showAlert = true
            return
        }
        
        guard newPassword == confirmPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT" // Use PUT instead of POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: Any] = ["email": email, "newPassword": newPassword]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Failed to reset password: \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    alertMessage = "Invalid response from server."
                    showAlert = true
                }
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                DispatchQueue.main.async {
                    isPasswordResetSuccessful = true // Navigate to LoginView
                }
            } else {
                DispatchQueue.main.async {
                    // Handle the response body if there are error details
                    if let data = data {
                        if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Response JSON: \(jsonResponse)") // Log the response for debugging
                        }
                    }
                    alertMessage = "Failed to reset password."
                    showAlert = true
                }
            }
        }.resume()
    }}
    
