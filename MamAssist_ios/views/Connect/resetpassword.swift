import SwiftUI

struct ResetPasswordView: View {
    @State private var email = ""

    var body: some View {
        NavigationView {
            ZStack {
                Image("resetpass")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    // Back Circle Button
                    HStack {
                        NavigationLink(destination: LoginViewWithAssetImage()) {
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                )
                        }
                        .padding(.top, 30) // Adjust the top padding to position the back button
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Align to the leading edge

                    // Title
                    Text("Reset Password")
                        .font(.largeTitle)
                        .padding(.top, 40) // Add some space between the back button and title
                    
                    // Email TextField
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Spacer() // Use a small spacer to lift the button up a bit

                    // Reset Password Button
                    Button(action: {
                        // Action to reset password
                    }) {
                        Text("Reset Password")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 60) // Push the button up by reducing bottom padding
                }
                .padding()
                .navigationBarHidden(true) // Hide the default navigation bar


            }
        }
    }
}

// Placeholder for LoginView
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
