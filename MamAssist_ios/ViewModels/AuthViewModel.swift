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

    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3001/auth/login") else {
            loginMessage = "Invalid URL"
            completion(false)
            return
        }

        let credentials = ["email": email, "password": password]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            loginMessage = "Error serializing credentials"
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.loginMessage = "Login failed: \(error.localizedDescription)"
                    completion(false)
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.loginMessage = "Invalid response from server"
                    completion(false)
                }
                return
            }

            print("HTTP Status Code: \(httpResponse.statusCode)") // Log the status code

            guard let data = data else {
                DispatchQueue.main.async {
                    self.loginMessage = "No data received"
                    completion(false)
                }
                return
            }

            // Log the raw response data as a string for inspection
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw Response Data: \(responseString)")
            }

            do {
                // Attempt to parse the response JSON
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response JSON: \(jsonResponse)") // Log the response JSON

                    // Now access the tokens and userId
                    if let accessToken = jsonResponse["accessToken"] as? String,
                       let refreshToken = jsonResponse["refreshToken"] as? String,
                       let userId = jsonResponse["userId"] as? String {
                        
                        DispatchQueue.main.async {
                            self.loginMessage = "Login successful!"
                            // Store tokens or userId as needed
                            // For example, save the accessToken for further API calls
                            // self.accessToken = accessToken
                            // self.userId = userId
                        }
                        completion(true)
                    } else {
                        DispatchQueue.main.async {
                            self.loginMessage = "Unexpected response structure: missing tokens"
                            completion(false)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.loginMessage = "Unexpected response structure: not a dictionary"
                        completion(false)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.loginMessage = "Error decoding response: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }.resume()
    }
    func signup(username: String, email: String, password: String, bio: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3001/auth/signup") else {
            signupMessage = "Invalid URL"
            completion(false)
            return
        }

        let userDetails: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "bio": bio,
            "imageUri": "test" // Placeholder for user image URI
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userDetails, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            signupMessage = "Error serializing user details"
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.signupMessage = "Signup failed: \(error.localizedDescription)"
                    completion(false)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.signupMessage = "No data received"
                    completion(false)
                }
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let success = jsonResponse["success"] as? Bool {
                        DispatchQueue.main.async {
                            self.signupMessage = success ? "Signup successful!" : "Signup failed."
                            completion(success)
                        }
                    } else {
                        let message = jsonResponse["message"] as? String ?? "Unexpected response structure."
                        DispatchQueue.main.async {
                            self.signupMessage = message
                            completion(false)
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.signupMessage = "Error decoding response: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }.resume()
    }
}
