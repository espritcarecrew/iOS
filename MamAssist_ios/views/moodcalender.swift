import SwiftUI

struct MoodCalendarView: View {
    @State private var selectedDate = Date()
    @State private var moods: [MoodEntry] = [] // API response data
    @State private var showDetails = false // Toggle for showing the bottom sheet
    @State private var selectedMoods: [MoodEntry] = [] // Filtered moods for the selected date
    @State private var count = 0 // State variable to track the counter value
    @State private var statistics: MoodStatistics? = nil // Holds statistics data

    var body: some View {
        VStack {
            // Calendar Section
            VStack(spacing: 16) {
                Text("Select a Date")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)

                // Calendar with Emoji Overlay
                CalendarWithEmojis(selectedDate: $selectedDate, moods: moods)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                    )
                    .padding(.horizontal)
            }

            Spacer()

            // Statistics Section
            if let stats = statistics {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Mood Statistics")
                        .font(.headline)
                        .foregroundColor(.purple)

                    HStack {
                        Text("Most Common Mood:")
                            .font(.subheadline)

                        Text(moodEmoji(for: stats.mostCommonMood))
                            .font(.title)
                    }

                    Text("Top Discomforts: \(stats.topDiscomforts.joined(separator: ", "))")
                        .font(.subheadline)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                )
                .padding(.horizontal)
            }

            Spacer()

            // Show Details Button
            Button(action: {
                filterMoodsForSelectedDate()
                showDetails.toggle()
            }) {
                Text("Show Mood Details")
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
                    .shadow(color: .purple.opacity(0.4), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal)

            Spacer()
        }
        .sheet(isPresented: $showDetails) {
            MoodDetailsView(moods: selectedMoods, selectedDate: formattedDate())
        }
        .onAppear {
            fetchMoods()
            fetchStatistics()
        }
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
    }

    // Filter moods for the selected date
    private func filterMoodsForSelectedDate() {
        selectedMoods = moods.filter { $0.date == formattedDate() }
    }

    // Fetch mood data from backend
    private func fetchMoods() {
        let apiUrl = "http://localhost:3000/moods" // Update with your API endpoint

        guard let url = URL(string: apiUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching moods: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                moods = try JSONDecoder().decode([MoodEntry].self, from: data)
                print("Fetched moods:", moods)
            } catch {
                print("Error decoding moods: \(error)")
            }
        }.resume()
    }

    // Fetch statistics data from backend
    private func fetchStatistics() {
        let apiUrl = "http://localhost:3000/moods/statistics" // Update with your API endpoint

        guard let url = URL(string: apiUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching statistics: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                statistics = try JSONDecoder().decode(MoodStatistics.self, from: data)
                print("Fetched statistics:", statistics ?? "No data")
            } catch {
                print("Error decoding statistics: \(error)")
            }
        }.resume()
    }

    // Helper function to format the date
    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }

    // Helper function to get emoji for a mood
    private func moodEmoji(for mood: String) -> String {
        switch mood.lowercased() {
        case "angry": return "😡"
        case "worried": return "😟"
        case "neutral": return "😐"
        case "happy": return "😊"
        case "very happy": return "😁"
        default: return "😐"
        }
    }
}

struct CalendarWithEmojis: View {
    @Binding var selectedDate: Date
    let moods: [MoodEntry]

    var body: some View {
        ZStack {
            // Base Calendar
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
        }
    }

    private func dateFromString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.date(from: dateString)
    }
}

struct MoodDetailsView: View {
    let moods: [MoodEntry]
    let selectedDate: String

    var body: some View {
        VStack(spacing: 16) {
            Text("Moods for \(selectedDate)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.top)

            if moods.isEmpty {
                Text("No mood data available for this date.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(moods) { mood in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Mood: \(moodstring(for: mood.mood))")
                                    .font(.headline)
                                Text("Discomforts: \(mood.discomforts.joined(separator: ", "))")
                                    .font(.subheadline)
                                Text("Notes: \(mood.notes)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                            )
                        }
                    }
                    .padding()
                }
            }

            Spacer()
        }
        .padding()
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
    }
}

struct MoodEntry: Identifiable, Decodable {
    var id: String { date }
    let date: String
    let mood: Int
    let discomforts: [String]
    let notes: String
}
private func moodstring(for mood: Int) -> String {
    switch mood {
    case 0: return "😡"
    case 1: return "😟"
    case 2: return "😐"
    case 3: return "😊"
    case 4: return "😁"
    default: return "😐"
    }
}


struct MoodStatistics: Decodable {
    let mostCommonMood: String
    let topDiscomforts: [String]
}

struct MoodCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MoodCalendarView()
    }
}
