import SwiftUI

struct VerifyCodeView: View {
    let email: String // Passed from ResetPasswordView
    @State private var verificationCode = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var navigateToNewPassword = false // Controls navigation

    var body: some View {
        NavigationStack {
            VStack {
                Text("Enter Verification Code")
                    .font(.title)
                    .padding(.bottom, 20)

                TextField("Verification Code", text: $verificationCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()

                Button(action: {
                    verifyCode()
                }) {
                    Text("Verify Code")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                // Navigation trigger to NewPasswordView
                NavigationLink(
                    destination: NewPasswordView(email: email),
                    isActive: $navigateToNewPassword
                ) {
                    EmptyView()
                }
            }
            .padding()
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    private func verifyCode() {
        guard !verificationCode.isEmpty else {
            alertMessage = "Please enter the verification code."
            showAlert = true
            return
        }

        guard let url = URL(string: "http://localhost:3000/mail/verify-code") else {
            alertMessage = "Invalid URL."
            showAlert = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: Any] = ["email": email, "code": verificationCode]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = "Failed to verify code: \(error.localizedDescription)"
                    self.showAlert = true
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                DispatchQueue.main.async {
                    self.alertMessage = "Invalid response from server."
                    self.showAlert = true
                }
                return
            }

            if (200...299).contains(httpResponse.statusCode)  {
                DispatchQueue.main.async {
                    // Handle the success case: success = true, proceed with the logic
                    if let serverResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let success = serverResponse["success"] as? Bool, success {
                            // If success is true, perform actions (e.g., navigate to another screen)
                            self.navigateToNewPassword = true
                        } else {
                            // If success is false, show the error message
                            self.alertMessage = serverResponse["message"] as? String ?? "Unknown error occurred."
                            self.showAlert = true
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    // Handle the failure case if the status code is not 200
                    self.alertMessage = "Failed to connect to the server."
                    self.showAlert = true
                }
            }
        }.resume()
    }
}
