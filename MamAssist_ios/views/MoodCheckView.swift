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

    var body: some View {
        VStack(spacing: 0) {
            // Scrollable content
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

                        // Discomfort Table
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
                                        .frame(maxWidth: .infinity) // Make buttons equal width
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
                .padding(.bottom, 16) // Ensures scrollable content has padding at the bottom
            }

            // Fixed Save Button at the Bottom
            Button(action: {
                // Save action
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
            .background(Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)) // Adds shadow for the button bar
        }
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
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
}

struct MoodCheckView_Previews: PreviewProvider {
    static var previews: some View {
        MoodCheckView()
            .previewDevice("iPhone 14")
            .previewDisplayName("Mood Check Preview")
    }
}
