import SwiftUI

struct Loginpage: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email: String = UserDefaults.standard.string(forKey: "userEmail") ?? "" // Retrieve stored email
    @State private var password: String = UserDefaults.standard.string(forKey: "userPassword") ?? "" // Retrieve stored password
    @State private var isLoginSuccessful: Bool = false // State to track login success
    @State private var showErrorAlert: Bool = false // State to control alert presentation
    @State private var rememberMe: Bool = UserDefaults.standard.bool(forKey: "rememberMe") // Store "Remember Me" preference

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

                        // Remember Me Toggle
                        Toggle(isOn: $rememberMe) {
                            Text("Remember Me")
                                .foregroundColor(.purple)
                        }
                        .padding()
                    }
                    .padding(.horizontal, 30)

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
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(authViewModel.loginMessage)
            }
            .onAppear {
                if let userEmail = UserDefaults.standard.string(forKey: "userEmail"), !userEmail.isEmpty {
                    print("Email is set: \(userEmail)")
                    autoLoginIfRemembered()
                }
                
            }
        }
    }

    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            authViewModel.loginMessage = "Please enter both email and password."
            showErrorAlert = true
            return
        }

        authViewModel.login(email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    print("Login successful!")
                    isLoginSuccessful = true // Trigger navigation to the home page

                    // Save login info if "Remember Me" is checked
                    if rememberMe {
                        UserDefaults.standard.set(email, forKey: "userEmail")
                        UserDefaults.standard.set(password, forKey: "userPassword")
                        UserDefaults.standard.set(true, forKey: "rememberMe")
                    } else {
                        // Clear stored login info
                        UserDefaults.standard.removeObject(forKey: "userEmail")
                        UserDefaults.standard.removeObject(forKey: "userPassword")
                        UserDefaults.standard.set(false, forKey: "rememberMe")
                    }
                } else {
                    print("Login failed: \(self.authViewModel.loginMessage)")
                    showErrorAlert = true
                }
            }
        }
    }


    private func autoLoginIfRemembered() {
        
        if rememberMe, !email.isEmpty, !password.isEmpty {
            // Attempt auto-login
            authViewModel.login(email: email, password: password) { success in
                if success {
                    print("Auto-login successful!")
                    isLoginSuccessful = true
                } else {
                    print("Auto-login failed: \(authViewModel.loginMessage)")
                }
            }
        }
    }
}
struct Loginpage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Loginpage()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light Mode")
            
            Loginpage()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
