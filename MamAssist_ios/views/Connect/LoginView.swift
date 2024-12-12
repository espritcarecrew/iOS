import SwiftUI

struct LoginViewWithAssetImage: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email: String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
    @State private var password: String = UserDefaults.standard.string(forKey: "userPassword") ?? ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoginSuccessful: Bool = false
    @State private var rememberMe: Bool = UserDefaults.standard.bool(forKey: "rememberMe")
    @State private var showErrorAlert: Bool = false
    @State private var loginMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                // Top bar
                HStack {
                    Spacer()
                    Text("Connexion")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)

                Spacer().frame(height: 50)

                // Asset Image
                Image("femme")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 20)

                // Email and Password Fields
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 15)

                    HStack {
                        if isPasswordVisible {
                            TextField("Mot de passe", text: $password)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        } else {
                            SecureField("Mot de passe", text: $password)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.horizontal, 16)
                }

                // Remember Me Toggle
                Toggle(isOn: $rememberMe) {
                    Text("Se souvenir de moi")
                        .foregroundColor(.purple)
                }
                .padding(.horizontal, 16)

                Spacer().frame(height: 16)

                // Login Button
                Button(action: {
                    login()
                }) {
                    Text("Se connecter")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.pink]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                }

                Spacer()

                // Forget Password Button
                NavigationLink(destination: ResetPasswordView().navigationBarBackButtonHidden(true)) {
                    Text("Mot de passe oublié ?")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                        .padding(.top, 8)
                }

                Spacer().frame(height: 16)

                // Sign-Up Section
                HStack {
                    Text("Pas de compte ?")
                        .foregroundColor(.gray)
                    NavigationLink(destination: SignupView().navigationBarBackButtonHidden(true)) {
                        Text("S'inscrire")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                    }
                }
                .padding(.bottom, 16)
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isLoginSuccessful) {
                HomeView() // Ensure HomeView exists
                    .navigationBarBackButtonHidden(true)
            }
            .alert("Erreur", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(loginMessage)
            }
            .onAppear {
                autoLoginIfRemembered()
            }
        }
    }

    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            loginMessage = "Please enter both email and password."
            showErrorAlert = true
            return
        }

        authViewModel.login(email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    print("Login successful!")
                    isLoginSuccessful = true

                    // Save login info if "Remember Me" is checked
                    if rememberMe {
                        UserDefaults.standard.set(email, forKey: "userEmail")
                        UserDefaults.standard.set(password, forKey: "userPassword")
                        UserDefaults.standard.set(true, forKey: "rememberMe")
                    } else {
                        UserDefaults.standard.removeObject(forKey: "userEmail")
                        UserDefaults.standard.removeObject(forKey: "userPassword")
                        UserDefaults.standard.set(false, forKey: "rememberMe")
                    }
                } else {
                    print("Login failed: \(authViewModel.loginMessage)")
                    loginMessage = authViewModel.loginMessage
                    showErrorAlert = true
                }
            }
        }
    }

    private func autoLoginIfRemembered() {
        if rememberMe, !email.isEmpty, !password.isEmpty {
            authViewModel.login(email: email, password: password) { success in
                DispatchQueue.main.async {
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
}

struct LoginViewWithAssetImage_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewWithAssetImage()
    }
}
