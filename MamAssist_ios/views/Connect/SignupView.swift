import SwiftUI

struct SignupView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var bio: String = ""
    @State private var signupMessage: String = ""
    @State private var imageUri: String = "test" // Placeholder for image URI
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("register") // Replace with your background image name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer() // Push content down

                    Text("Signup")
                        .font(.largeTitle)
                        .padding()

                    // Image Selection
                    VStack {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                        } else {
                            Button(action: {
                                isImagePickerPresented = true
                            }) {
                                VStack {
                                    Image(systemName: "photo.on.rectangle")
                                        .font(.largeTitle)
                                        .foregroundColor(.gray)
                                    Text("Ajouter une image")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
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

                    Spacer() // Push content up
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.all) // Ensure the view occupies the full screen
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePickerView(selectedImage: $selectedImage)
            }
        }
    }

    private func signup() {
        guard let url = URL(string: "http://localhost:3001/auth/signup") else {
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
                    signupMessage = "Signup failed: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    signupMessage = "No data received"
                }
                return
            }

            // Log the raw response data
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }

            // Decode the response from the backend
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let success = jsonResponse["success"] as? Bool {
                        DispatchQueue.main.async {
                            signupMessage = success ? "Signup successful!" : "Signup failed."
                        }
                    } else {
                        let message = jsonResponse["message"] as? String ?? "Unexpected response structure."
                        DispatchQueue.main.async {
                            signupMessage = message
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    signupMessage = "Error decoding response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

// ImagePicker to select an image
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
