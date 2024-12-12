import SwiftUI

struct ResetPasswordView: View {
    @State private var email = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isVerificationCodeSent = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("resetpass")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    // Title
                    Text("Reset Password")
                        .font(.largeTitle)
                        .padding(.top, 40)
                    
                    // Email TextField
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Spacer()

                    // Send Verification Code Button
                    Button(action: {
                        sendVerificationCode()
                    }) {
                        Text("Send Verification Code")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 60)
                    
                    // Navigation to VerifyCodeView after successful code sending
                    NavigationLink(
                        destination: VerifyCodeView(email: email),
                        isActive: $isVerificationCodeSent
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
        .navigationBarHidden(true)
    }

    private func sendVerificationCode() {
        guard let url = URL(string: "http://localhost:3000/mail/send-code") else {
            alertMessage = "Invalid URL."
            showAlert = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: Any] = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Failed to send verification code: \(error.localizedDescription)"
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
                    isVerificationCodeSent = true // Navigate to VerifyCodeView
                }
            } else {
                DispatchQueue.main.async {
                    alertMessage = "Failed to send verification code. Server returned status code \(httpResponse.statusCode)."
                    showAlert = true
                }
            }
        }.resume()
    }
}
