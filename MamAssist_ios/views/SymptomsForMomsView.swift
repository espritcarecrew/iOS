import SwiftUI

struct SymptomsForMomsView: View {
    @State private var searchText: String = "" // For the search bar
    @State private var selectedSymptoms: Set<String> = [] // Tracks selected symptoms

    let symptomsData = [
        "General": ["crying", "clinginess", "sleeplessness", "restlessness", "fever", "cold symptoms"],
        "Head & neck": ["ear infections", "teething", "head bumps", "eye irritation", "vision issues"],
        "Chest & back": ["coughing", "difficulty breathing", "chest pain", "skin rashes"],
        "Stomach/digestive": ["vomiting", "diarrhea", "constipation", "stomach cramps", "reduced appetite", "gassiness"]
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Top Bar
          
            // Section Title
            HStack(spacing: 10) {
                Image(systemName: "stethoscope")
                    .foregroundColor(.blue)
                Text("baby symptoms")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            // Subtitle
            Text("What's your baby experiencing today?")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(8)
            }
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal)
            
            // Symptoms List and Button
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Symptoms List
                    ForEach(symptomsData.keys.sorted(), id: \.self) { section in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(section)
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            // Pills for symptoms
                            let symptoms = symptomsData[section] ?? []
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                ForEach(symptoms, id: \.self) { symptom in
                                    SymptomButton(symptom: symptom, isSelected: selectedSymptoms.contains(symptom)) {
                                        if selectedSymptoms.contains(symptom) {
                                            selectedSymptoms.remove(symptom)
                                        } else {
                                            selectedSymptoms.insert(symptom)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Submit Button
                    Button(action: {
                        // Handle button action
                        print("Selected Symptoms: \(selectedSymptoms)")
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 20) // Adds some spacing at the end
                }
                .padding(.top, 10)
            }
        }
        .background(Color(.systemGray5).edgesIgnoringSafeArea(.all))
    }
}

struct SymptomButton: View { // Renamed to avoid conflict
    let symptom: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(symptom)
                    .font(.footnote)
                    .foregroundColor(isSelected ? .white : .blue)
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.footnote)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.blue : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 1)
                    )
            )
        }
    }
}

struct SymptomsForMomsView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomsForMomsView()
    }
}
