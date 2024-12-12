import SwiftUI

struct AIQueryView: View {
    @State private var question: String = "" // For the user's question
    @State private var aiResponse: String = "" // To store the AI's response
    @State private var isLoading: Bool = false // To show/hide loading indicator

    var body: some View {
        VStack {
            // Title
            Text("Ask AI")
                .font(.largeTitle)
                .padding()

            // TextField for user input
            TextField("Enter your question", text: $question)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Button to send the request
            Button(action: {
                sendRequestToAI()
            }) {
                Text("Ask AI")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // Show loading indicator while waiting for response
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }

            // Display AI's response
            ScrollView {
                Text(aiResponse)
                    .padding()
            }

            Spacer()
        }
        .padding()
    }

    // Function to send the request to the AI API
    func sendRequestToAI() {
        print("Debug: Starting API request...")

        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=YOUR_API_KEY") else {
            print("Debug: Invalid URL")
            aiResponse = "Invalid URL"
            return
        }
        print("Debug: URL is valid: \(url)")

        let body: [String: Any] = [
            "prompt": [
                "text": question
            ],
            "temperature": 0.7
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert the body to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
            print("Debug: Request body: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")
        } catch {
            print("Debug: Error in formatting the request body: \(error.localizedDescription)")
            aiResponse = "Error in formatting the request body."
            return
        }

        // Show loading indicator
        isLoading = true

        // Send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                // Hide the loading indicator
                isLoading = false

                if let error = error {
                    print("Debug: Request failed with error: \(error.localizedDescription)")
                    aiResponse = "Request failed: \(error.localizedDescription)"
                    return
                }

                // Check the HTTP response
                if let httpResponse = response as? HTTPURLResponse {
                    print("Debug: HTTP Status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode != 200 {
                        aiResponse = "Failed with status code: \(httpResponse.statusCode)"
                        return
                    }
                }

                // Check if data is received
                guard let data = data else {
                    print("Debug: No data received from server.")
                    aiResponse = "No data received."
                    return
                }

                // Print the raw response in the console
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Debug: Raw Response from AI: \(responseString)")
                }

                // Parse the response data
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Print the JSON structure for debugging
                        print("Debug: Parsed JSON Response: \(jsonResponse)")

                        // Navigate through the JSON structure to get the desired text
                        if let candidates = jsonResponse["candidates"] as? [[String: Any]],
                           let content = candidates.first?["content"] as? [String: Any],
                           let parts = content["parts"] as? [[String: Any]],
                           let responseText = parts.first?["text"] as? String {
                            aiResponse = responseText // Set the AI response here
                            print("Debug: AI Response: \(responseText)")
                        } else {
                            aiResponse = "Unexpected response format."
                            print("Debug: Unexpected response format: \(jsonResponse)")
                        }
                    } else {
                        aiResponse = "Error: Invalid JSON format"
                        print("Debug: Error: Invalid JSON format")
                    }
                } catch {
                    aiResponse = "Error decoding response: \(error.localizedDescription)"
                    print("Debug: Error decoding response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

struct AIQueryView_Previews: PreviewProvider {
    static var previews: some View {
        AIQueryView()
    }
}
