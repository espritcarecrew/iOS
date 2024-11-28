import SwiftUI

struct Loginpage: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful: Bool = false // State to track login success
    @State private var showError: Bool = false // State to show error message

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image
                Image("loginscreen") // Replace with the name of your image asset
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    // Title Section
                    VStack(spacing: 10) {
                        Text("Login")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Welcome! Login to your account on MamAssist to access our content.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.purple)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 40)

                    Spacer()

                    // Social Login Buttons
                    VStack(spacing: 15) {
                        Button(action: {
                            // Handle Google Sign-In logic here
                        }) {
                            HStack {
                                Image(systemName: "globe")
                                    .foregroundColor(.white)
                                Text("Sign in with Google")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red) // Google color
                            .cornerRadius(8)
                        }
                        .padding(.horizontal, 30)

                        Button(action: {
                            // Handle Facebook Login logic here
                        }) {
                            HStack {
                                Image(systemName: "f.circle.fill")
                                    .foregroundColor(.white)
                                Text("Login with Facebook")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue) // Facebook color
                            .cornerRadius(8)
                        }
                        .padding(.horizontal, 30)
                    }

                    Text("OR")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()

                    // Email and Password Fields
                    VStack(spacing: 10) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(8)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 30)

                    // Error Message
                    if showError {
                        Text(authViewModel.loginMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.horizontal, 30)
                            .multilineTextAlignment(.center)
                    }

                    // Continue Button
                    Button(action: {
                        login()
                    }) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 30)

                    Spacer()

                    // Back to First Page Link
                    NavigationLink("Back to First Page", destination: Firstpage())
                        .foregroundColor(.purple)
                        .underline()
                        .padding(.bottom, 50)
                }
            }
            .navigationDestination(isPresented: $isLoginSuccessful) {
                HomeView().navigationBarHidden(true) // Navigate to Homepage when login is successful
            }
            .navigationBarHidden(true) // Completely hides the navigation bar
            .navigationBarBackButtonHidden(true) // Prevents back button
        }
    }

    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            authViewModel.loginMessage = "Please enter both email and password."
            showError = true
            return
        }

        authViewModel.login(email: email, password: password) { success in
            if success {
                // Handle successful login
                print("Login successful!")
                isLoginSuccessful = true // Trigger navigation to the home page
                showError = false
            } else {
                // Handle login failure
                print("Login failed: \(self.authViewModel.loginMessage)")
                showError = true
            }
        }
    }
}

struct Loginpage_Previews: PreviewProvider {
    static var previews: some View {
        Loginpage()
    }
}
