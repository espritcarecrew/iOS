import SwiftUI

struct MoodCheckView: View {
    @State private var selectedDate = Date() // Date picker state
    @State private var selectedMood: Int? = 2 // Currently selected mood (index)
    @State private var discomforts: [String] = [
        "Contractions", "Heartburn", "Swelling", "Anxiety", "Back pain",
        "Pain", "Pelvic pain", "Fatigue", "Depression", "Nausea", "Fluctuating emotions"
    ] // Discomfort tags
    @State private var selectedDiscomforts: Set<String> = [] // Tracks selected discomforts
    @State private var notes: String = "" // Text area content

    @State private var apiResponse: String? = nil // Holds API response
    @State private var navigateToResponseView = false // Triggers navigation to response view

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        // Top Bar
                        HStack {
                            Spacer()
                            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                            Spacer()
                            Button(action: {
                                // Close action
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)

                        // Title
                        Text("How are you today?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.purple)
                            .padding(.horizontal)

                        // Mood Emojis in a Container
                        VStack(spacing: 16) {
                            Text("Select your mood")
                                .font(.headline)
                                .foregroundColor(.purple)

                            HStack(spacing: 20) {
                                ForEach(0..<5) { moodIndex in
                                    Button(action: {
                                        selectedMood = moodIndex
                                    }) {
                                        Circle()
                                            .stroke(moodIndex == selectedMood ? Color.purple : Color.clear, lineWidth: 3)
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                Text(moodEmoji(for: moodIndex))
                                                    .font(.largeTitle)
                                            )
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        )
                        .padding(.horizontal)

                        // Discomfort Tags in a Table-like Container
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Are you experiencing any discomfort?")
                                .font(.headline)
                                .foregroundColor(.purple)

                            LazyVGrid(
                                columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),
                                spacing: 10
                            ) {
                                ForEach(discomforts, id: \.self) { discomfort in
                                    Button(action: {
                                        if selectedDiscomforts.contains(discomfort) {
                                            selectedDiscomforts.remove(discomfort)
                                        } else {
                                            selectedDiscomforts.insert(discomfort)
                                        }
                                    }) {
                                        Text(discomfort)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .frame(maxWidth: .infinity)
                                            .background(selectedDiscomforts.contains(discomfort) ? Color.purple.opacity(0.2) : Color.clear)
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.purple, lineWidth: 1)
                                            )
                                            .foregroundColor(.purple)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        )
                        .padding(.horizontal)

                        // Text Area
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Do you want to elaborate?")
                                .font(.headline)
                                .foregroundColor(.purple)
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.purple, lineWidth: 1)
                                    .background(Color.white)
                                    .frame(height: 100)

                                TextEditor(text: $notes)
                                    .padding(8)
                                    .frame(height: 100)
                                    .overlay(
                                        Group {
                                            if notes.isEmpty {
                                                Text("Write here...")
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal, 12)
                                                    .padding(.vertical, 8)
                                                    .allowsHitTesting(false)
                                            }
                                        }
                                    )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                    }
                    .padding(.bottom, 16)
                }

                // NavigationLink to navigate to ResponseView
                NavigationLink(destination: ResponseView(responseText: apiResponse ?? ""), isActive: $navigateToResponseView) {
                    EmptyView()
                }

                // Fixed Save Button at the Bottom
                Button(action: {
                    sendToBackend()
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .background(Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5))
            }
            .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
        }
    }

    // Helper function for mood emojis
    func moodEmoji(for index: Int) -> String {
        switch index {
        case 0: return "😡"
        case 1: return "😟"
        case 2: return "😐"
        case 3: return "😊"
        case 4: return "😁"
        default: return "😐"
        }
    }

    // Helper function to generate a summary of the data
    func generateSummary() -> String {
        let moodDescription: String
        switch selectedMood {
        case 0: moodDescription = "Angry 😡"
        case 1: moodDescription = "Worried 😟"
        case 2: moodDescription = "Neutral 😐"
        case 3: moodDescription = "Happy 😊"
        case 4: moodDescription = "Very Happy 😁"
        default: moodDescription = "Neutral 😐"
        }

        let discomfortsList = selectedDiscomforts.joined(separator: ", ")
        let discomfortText = discomfortsList.isEmpty ? "No discomforts reported." : "Discomforts: \(discomfortsList)."

        let notesText = notes.isEmpty ? "No additional notes provided." : "Notes: \(notes)."

        return """
        Mood Check Summary:
        Date: \(formattedDate())
        Mood: \(moodDescription)
        \(discomfortText)
        \(notesText)
        """
    }

    // Helper function to format the date
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }

    // Function to send the data to the API
    func sendToBackend() {
        let apiUrl = "http://localhost:3000/moods" // Update with your API endpoint

        guard let url = URL(string: apiUrl) else {
            print("Invalid URL.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let moodData: [String: Any] = [
            "date": formattedDate(),
            "mood": selectedMood ?? 2,
            "discomforts": Array(selectedDiscomforts),
            "notes": notes
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: moodData, options: [])
        } catch {
            print("Failed to encode mood data: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending data to backend: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response from server.")
                return
            }

            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                print("Mood data saved successfully.")
            } else {
                print("Failed to save mood data. Status code: \(httpResponse.statusCode)")
            }
        }.resume()
    }
}

struct MoodCheckView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoodCheckView()
        }
    }
}
