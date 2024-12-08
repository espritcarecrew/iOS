import SwiftUI

struct LoginViewWithAssetImage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack {
            // Top bar with back button and title
            HStack {
                Button(action: {
                    print("Retour")
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Connexion")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)

            Spacer().frame(height: 50)

            // Display Image from Assets
            Image("femme") // Remplacez "femme" par le nom de votre image dans Assets
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.bottom, 20)

            Spacer()

            // Email text field
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 15)

                // Password text field with visibility toggle
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

            Spacer().frame(height: 16)
                // Forgot password text
                Button(action: {
                    print("Mot de passe oublié")
                }) {
                    NavigationLink(destination: ResetPasswordView()) {

                    Text("Mot de passe oublié")
                        .font(.footnote)
                        .foregroundColor(.purple)
                } }
            .padding(.top, 8)

            Spacer()

            // Connect via phone text
            Text("Se connecter via téléphone")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 8)

            // Login button
            Button(action: {
                print("Se connecter")
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

            Spacer().frame(height: 10)

            // Social login options with custom images
            HStack(spacing: 16) {
                SocialLoginButton(
                    imageName: "google", // Remplacez par le nom de votre image
                    imageSize: CGSize(width: 50, height: 50) // Ajustez la taille ici
                ) {
                    print("Connexion via Google")
                }

                SocialLoginButton(
                    imageName: "facebook_logo", // Remplacez par le nom de votre image
                    imageSize: CGSize(width: 30, height: 30) // Ajustez la taille ici
                ) {
                    print("Connexion via Facebook")
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)

            Spacer().frame(height: 16)

            // Sign up text
            HStack {
                Text("Pas de compte ?")
                    .foregroundColor(.gray)
                Button(action: {
                    print("S'inscrire")
                }) {
                    Text("S'inscrire")
                        .foregroundColor(.purple)
                        .fontWeight(.bold)
                }
            }
            .padding(.bottom, 16)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct SocialLoginButton: View {
    let imageName: String
    let imageSize: CGSize
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height) // Taille de l'image
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct LoginViewWithAssetImage_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewWithAssetImage()
    }
}
