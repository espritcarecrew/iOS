//
//  AuthViewModel.swift
//  MamAssist
//
//  Created by med karim checambou on 19/11/2024.
//
import Foundation

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var loginMessage: String = ""
    @Published var signupMessage: String = ""

    // Function to perform login
       func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
           guard let url = URL(string: "http://localhost:3000/auth/login") else {
               completion(false)
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           let body = ["email": email, "password": password]
           request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)

           URLSession.shared.dataTask(with: request) { data, response, error in
               guard let data = data, error == nil else {
                   DispatchQueue.main.async {
                       self.loginMessage = "Network error. Please try again."
                       completion(false)
                   }
                   return
               }

               do {
                   // Parse the login response
                   if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let accessToken = json["accessToken"] as? String {

                       // Now that we have the access token, we can fetch the full user details using /auth/find
                       self.fetchUserByEmail(email: email) { user in
                           if let user = user {
                               DispatchQueue.main.async {
                                   // Store the user entity in UserDefaults
                                   self.storeUserInDefaults(user: user)
                                   completion(true)
                               }
                           } else {
                               DispatchQueue.main.async {
                                   self.loginMessage = "Failed to fetch user details."
                                   completion(false)
                               }
                           }
                       }

                   } else {
                       DispatchQueue.main.async {
                           self.loginMessage = "Invalid credentials."
                           completion(false)
                       }
                   }
               } catch {
                   DispatchQueue.main.async {
                       self.loginMessage = "Error parsing server response."
                       completion(false)
                   }
               }
           }.resume()
       }

       // Fetch user by email from /auth/find endpoint
       private func fetchUserByEmail(email: String, completion: @escaping ([String: Any]?) -> Void) {
           guard let url = URL(string: "http://localhost:3000/auth/find?field=email&value=\(email)") else {
               completion(nil)
               return
           }

           URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else {
                   completion(nil)
                   return
               }

               do {
                   if let user = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                       completion(user)
                   } else {
                       completion(nil)
                   }
               } catch {
                   completion(nil)
               }
           }.resume()
       }

       // Store user details in UserDefaults
       private func storeUserInDefaults(user: [String: Any]) {
           if let username = user["username"] as? String,
              let email = user["email"] as? String,
              let bio = user["bio"] as? String,
              let imageUri = user["imageUri"] as? String? {
               
               // Store the user details in UserDefaults
               UserDefaults.standard.set(username, forKey: "userName")
               UserDefaults.standard.set(email, forKey: "userEmail")
               UserDefaults.standard.set(bio, forKey: "userBio")
               UserDefaults.standard.set(imageUri, forKey: "imageUri")
           }
       
   }
    func signup(username: String, email: String, password: String, bio: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/auth/signup") else {
            DispatchQueue.main.async {
                self.signupMessage = "Invalid URL"
                completion(false)
            }
            return
        }

        // User details payload
        let userDetails: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "bio": bio,
            "imageUri": "https://example.com/images/default-profile.jpg" // Placeholder for user image URI
        ]

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            // Convert user details to JSON data
            request.httpBody = try JSONSerialization.data(withJSONObject: userDetails, options: [])
        } catch {
            DispatchQueue.main.async {
                print("Error serializing JSON: \(error)")
                self.signupMessage = "Error serializing user details"
                completion(false)
            }
            return
        }

        // Perform the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Signup failed with error: \(error.localizedDescription)")
                    self.signupMessage = "Signup failed: \(error.localizedDescription)"
                    completion(false)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    print("No data received from server.")
                    self.signupMessage = "No data received"
                    completion(false)
                }
                return
            }

            // Parse the response
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let success = jsonResponse["success"] as? Bool, success == true {
                        DispatchQueue.main.async {
                            print("Signup successful! Response: \(jsonResponse)")
                            self.signupMessage = "Signup successful!"
                            completion(true)
                        }
                    } else {
                        let message = jsonResponse["message"] as? String ?? "Signup failed for an unknown reason."
                        DispatchQueue.main.async {
                            print("Signup failed with message: \(message)")
                            self.signupMessage = message
                            completion(false)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Unexpected response structure: \(data)")
                        self.signupMessage = "Unexpected response structure"
                        completion(false)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error decoding server response: \(error.localizedDescription)")
                    self.signupMessage = "Error decoding response: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }.resume()
    }

    
    
}
