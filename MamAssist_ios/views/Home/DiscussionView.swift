import SwiftUI

struct DiscussionView: View {
    @State private var messages: [ChatMessage] = [] // List of chat messages
    @State private var userInput: String = "" // User input text
    @State private var isLoading: Bool = false // Loading state for AI response

    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Bonjour,")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.leading, 16)

                Spacer()
            }
            .padding(.top, 20)

            Text("Notre équipe médicale répond à toutes vos questions liées à la grossesse et au post-partum sous 48 h")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
                .padding(.top, 8)

            // Chat area
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(messages) { message in
                            ChatBubble(message: message)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .onChange(of: messages) { _ in
                    withAnimation {
                        scrollViewProxy.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                }
            }

            // Input area
            HStack {
                TextField("Écrivez votre question...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 16)

                if isLoading {
                    ProgressView()
                        .padding(.trailing, 16)
                } else {
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.purple, Color.pink]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 16)
                }
            }
            .padding(.vertical, 8)

            // Reload button
            Button(action: resetChat) {
                Text("Recharger la conversation")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.pink]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }

    // Function to send a message
    private func sendMessage() {
        guard !userInput.isEmpty else { return }

        // Add user message to the chat
        let userMessage = ChatMessage(id: UUID(), text: userInput, isUser: true)
        messages.append(userMessage)
        userInput = "" // Clear input

        // Send to API
        sendToGemini(prompt: userMessage.text)
    }

    // Function to send the data to the API
    private func sendToGemini(prompt: String) {
        let apiUrl = "http://localhost:3000/gemini/generate"

        guard let url = URL(string: apiUrl) else {
            print("Invalid URL.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "prompt": prompt
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to encode request body: \(error)")
            return
        }

        isLoading = true

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending data to the API: \(error.localizedDescription)")
                isLoading = false
                return
            }

            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                print("No data or invalid response received from the API.")
                isLoading = false
                return
            }

            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                do {
                    if let responseObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let candidates = responseObject["candidates"] as? [[String: Any]],
                       let content = candidates.first?["content"] as? [String: Any],
                       let parts = content["parts"] as? [[String: Any]],
                       let text = parts.first?["text"] as? String {

                        DispatchQueue.main.async {
                            let aiResponse = ChatMessage(id: UUID(), text: text, isUser: false)
                            messages.append(aiResponse)
                            isLoading = false
                        }
                    } else {
                        print("Failed to extract text from response.")
                        isLoading = false
                    }
                } catch {
                    print("Error decoding response: \(error)")
                    isLoading = false
                }
            } else {
                print("Unexpected response from the API. Status code: \(httpResponse.statusCode)")
                if let rawResponse = String(data: data, encoding: .utf8) {
                    print("Raw Response: \(rawResponse)")
                }
                isLoading = false
            }
        }.resume()
    }

    // Function to reset the chat
    private func resetChat() {
        messages.removeAll()
    }
}

// Chat message model
struct ChatMessage: Identifiable, Equatable {
    let id: UUID
    let text: String
    let isUser: Bool
}

// Chat bubble view
struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .frame(maxWidth: 250, alignment: .trailing)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer()
            }
        }
    }
}

struct DiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionView()
    }
}
