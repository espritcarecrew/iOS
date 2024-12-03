import SwiftUI
import UIKit

struct ProfileView: View {
    // State variables
    @State private var userName: String = UserDefaults.standard.string(forKey: "userName") ?? "User Name"
    @State private var userEmail: String = UserDefaults.standard.string(forKey: "userEmail") ?? "email@example.com"
    @State private var bio: String = UserDefaults.standard.string(forKey: "userBio") ?? "Bio not available"
    @State private var imageUri: String? = UserDefaults.standard.string(forKey: "imageUri") // Image URL
    @State private var isLoggedOut: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var profileImage: UIImage? = nil // Fetched or updated profile image

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Profile Image Section
                ZStack {
                    if let profileImage = profileImage {
                        // Show locally selected image
                        Image(uiImage: profileImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else if let imageUri = imageUri, let url = URL(string: imageUri) {
                        // Show image from database (URL)
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } placeholder: {
                            // Placeholder while the image loads
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                    } else {
                        // Default placeholder
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }

                    // Edit button
                    Button(action: {
                        isImagePickerPresented = true // Show the image picker
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.purple)
                            .offset(x: 35, y: 35)
                    }
                }

                // User Details Section
                VStack(spacing: 8) {
                    Text(userName)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(userEmail)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(bio)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }

                // Action Section
                VStack(spacing: 16) {
                    ProfileRow(title: "Edit Profile", icon: "pencil.circle")
                    ProfileRow(title: "Settings", icon: "gearshape")
                    ProfileRow(title: "Notifications", icon: "bell.circle")
                    ProfileRow(title: "Privacy Policy", icon: "lock.circle")

                    // Log Out Button
                    Button(action: {
                        logOut()
                    }) {
                        ProfileRow(title: "Log Out", icon: "arrowshape.turn.up.left.circle")
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding()
            .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
            .onAppear {
                loadImage()
            }
            .navigationDestination(isPresented: $isLoggedOut) {
                Loginpage()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $profileImage)
            }
        }
    }

    // Log out functionality
    private func logOut() {
        // Clear stored user data
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userPassword")
        UserDefaults.standard.set(false, forKey: "rememberMe")
        // Navigate back to login page
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoggedOut = true
        }
    }

    // Load the image URL from UserDefaults or handle logic if needed
    private func loadImage() {
        if let imageUri = UserDefaults.standard.string(forKey: "imageUri"), let url = URL(string: imageUri) {
            print("Image URL loaded: \(url)")
        } else {
            print("No image URI found")
        }
    }
}

// Profile Row for Profile Details
struct ProfileRow: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.purple)

            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.purple)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 18))
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
        )
    }
}

// Image Picker Wrapper for UIKit
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
