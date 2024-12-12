import SwiftUI

struct SignupView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var bio: String = ""
    @State private var signupMessage: String = ""
    @State private var imageUri: String = "test" // Placeholder for image URI
    @State private var isSignupSuccessful: Bool = false // Navigate to home page upon success
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("register") // Replace with your background image name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text("Signup")
                        .font(.largeTitle)
                        .padding()
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    TextField("Bio", text: $bio)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: signup) {
                        Text("Signup")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Text(signupMessage)
                        .foregroundColor(.red)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                
                // Navigation to HomePage after successful signup
                NavigationLink(
                    destination: HomeView()
                        .navigationBarBackButtonHidden(true), // Disable the back button
                    isActive: $isSignupSuccessful
                ) {
                    EmptyView()
                }
            }
            .navigationBarBackButtonHidden(true) // Disable the back button in SignupView
        }
    }
    
    private func signup() {
        guard let url = URL(string: "http://localhost:3000/auth/signup") else {
            signupMessage = "Invalid URL"
            return
        }
        
        let userDetails: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "bio": bio,
            "imageUri": imageUri
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userDetails, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            signupMessage = "Error serializing user details"
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Signup failed with error: \(error.localizedDescription)")
                    signupMessage = "Signup failed: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print("No data received from server.")
                    signupMessage = "No data received"
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Handle the response based on 'success' key
                    if let success = jsonResponse["success"] as? Bool, success == true {
                        DispatchQueue.main.async {
                            print("Signup successful! Response: \(jsonResponse)")
                            if let user = jsonResponse["user"] as? [String: Any] {
                                self.storeUserInDefaults(user: user) // Store user details
                            }
                            self.signupMessage = "Signup successful!"
                            self.isSignupSuccessful = true // Navigate to HomePage
                        }
                    } else {
                        let message = jsonResponse["message"] as? String ?? "Signup failed for an unknown reason."
                        DispatchQueue.main.async {
                            print("Signup failed with message: \(message)")
                            signupMessage = message
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Unexpected response structure.")
                        signupMessage = "Unexpected response structure"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error decoding server response: \(error.localizedDescription)")
                    signupMessage = "Error decoding response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    // Store user details in UserDefaults
    private func storeUserInDefaults(user: [String: Any]) {
        if let username = user["username"] as? String,
           let email = user["email"] as? String,
           let bio = user["bio"] as? String,
           let imageUri = user["imageUri"] as? String { // Explicitly check for a non-nil string
            UserDefaults.standard.set(username, forKey: "userName")
            UserDefaults.standard.set(email, forKey: "userEmail")
            UserDefaults.standard.set(bio, forKey: "userBio")
            UserDefaults.standard.set(imageUri, forKey: "imageUri")
        } else {
            print("Error: Missing user data.")
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
