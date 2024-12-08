import SwiftUI

struct PregnancyTrackerView: View {
    @State private var dueDate: Date = Date()
    @State private var lastPeriodDate: Date = Date()
    @State private var isDueDateSelected = false
    @State private var navigateToPregnancyView = false // Pour la navigation

    var body: some View {
        VStack {
            // Top Image
            Image("baby_image") // Remplacez par le nom de votre image dans Assets
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .clipped()

            Spacer().frame(height: 20)

            // Title
            Text("Pregnancy tracker!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Spacer().frame(height: 10)

            // Subtitle
            Text("Set one of these dates")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer().frame(height: 20)

            // Due Date Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Due date")
                    .font(.subheadline)
                    .foregroundColor(.black)

                HStack {
                    TextField("Your Due Date", text: .constant(dateToString(dueDate)))
                        .disabled(true)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    Button(action: {
                        isDueDateSelected.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 10)

            // OR Divider
            Text("OR")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()

            // Last Period Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Last period")
                    .font(.subheadline)
                    .foregroundColor(.black)

                HStack {
                    TextField("First day of last period", text: .constant(dateToString(lastPeriodDate)))
                        .disabled(true)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    Button(action: {
                        isDueDateSelected.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            // Done Button
            NavigationLink(destination: SymptomsView(), isActive: $navigateToPregnancyView) {
                Button(action: {
                    navigateToPregnancyView = true
                }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }

            Spacer().frame(height: 20)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $isDueDateSelected) {
            DatePicker("Select Date", selection: $dueDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
        }
    }
    
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct PregnancyView: View {
    var body: some View {
        VStack {
            Text("Welcome to the Pregnancy View!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct PregnancyTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PregnancyTrackerView()
        }
    }
}
