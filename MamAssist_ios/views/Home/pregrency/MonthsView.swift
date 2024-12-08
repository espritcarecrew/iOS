import SwiftUI

struct MonthsView: View {
    @State private var selectedMonth: Int = 5 // Default selected month
    @State private var selectedFragment: String = "Baby" // Toggle between "Baby" and "Mother"

    var body: some View {
        ZStack {
            // Background Image
            Image("resetpass")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Ensures it covers the whole screen

            ScrollView {
                VStack {
                    // Main Container
                    VStack(spacing: 20) {
                        // Month Title
                        Text("Month \(selectedMonth)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                            .padding(.top)

                        // Scrollable Months Buttons
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(1...9, id: \.self) { month in
                                    Circle()
                                        .fill(month == selectedMonth ? Color.purple : Color.gray.opacity(0.5))
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Text("\(month)")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        )
                                        .onTapGesture {
                                            selectedMonth = month
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Dynamic Image with Circular Background
                        ZStack {
                            Circle()
                                .fill(Color.pink.opacity(0.5)) // Pink circular background
                                .frame(width: 250, height: 250)

                            Image("\(selectedMonth)") // Ensure images are named "1", "2", ..., "9"
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle()) // Clip the image into a circle
                                .frame(width: 200, height: 200) // Adjust size for the image
                        }
                        .padding(.top)

                        // Growth Metrics
                        VStack(spacing: 8) {
                            Text("1 mm")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                            Text("Length")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top)

                        // Message
                        Text("Congratulations on your pregnancy!")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.purple.opacity(0.9))
                            .padding(.horizontal)

                        // Fragment Toggle (Baby - Mother)
                        HStack {
                            Button(action: {
                                selectedFragment = "Baby"
                            }) {
                                Text("Baby")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedFragment == "Baby" ? Color.purple : Color.gray.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            Button(action: {
                                selectedFragment = "Mother"
                            }) {
                                Text("Mother")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedFragment == "Mother" ? Color.purple : Color.gray.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)

                        // Description
                        Text(descriptionForFragment())
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.9))
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            )
                            .padding(.horizontal)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("PeachBackground"))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal, 16)

                    Spacer()
                }
                .padding(.vertical, 16)
            }
        }
        .navigationBarTitle("Monthly Overview", displayMode: .inline)
    }

    // Description for the selected fragment
    private func descriptionForFragment() -> String {
        if selectedFragment == "Baby" {
            return "Your baby is growing rapidly and developing new features every day. It's an exciting journey!"
        } else {
            return "Take care of your health and wellness. Remember to hydrate, eat nutritious food, and rest well."
        }
    }
}

struct MonthsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MonthsView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light Mode")
            MonthsView()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
