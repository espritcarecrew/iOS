import SwiftUI

struct BabySymptomsView: View {
    @State private var searchText: String = "" // For the search bar
    @State private var selectedSymptoms: Set<String> = [] // Tracks selected symptoms

    let symptomsData = [
        "Général": ["pleurs", "agitation", "fièvre", "rhume", "sommeil perturbé"],
        "Tête et cou": ["infection des oreilles", "dents qui poussent", "maux de tête", "irritation des yeux"],
        "Poitrine et dos": ["toux", "douleurs thoraciques", "difficulté à respirer", "éruptions cutanées"],
        "Estomac et digestion": ["vomissements", "diarrhée", "constipation", "douleurs abdominales", "gaz"]
    ]

    var body: some View {
        ScrollView { // Rendre toute la page défilable
            VStack(spacing: 0) {
                // Titre de la section
                HStack(spacing: 10) {
                    Image(systemName: "stethoscope")
                        .foregroundColor(.blue)
                    Text("Symptômes du bébé")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Sous-titre
                Text("Quels symptômes présente votre bébé aujourd'hui ?")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Barre de recherche
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Rechercher", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(8)
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                )
                .padding(.horizontal)
                
                // Liste des symptômes
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(symptomsData.keys.sorted(), id: \.self) { section in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(section)
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            // Boutons de type "pill" pour les symptômes
                            let symptoms = symptomsData[section] ?? []
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                ForEach(symptoms, id: \.self) { symptom in
                                    BabySymptomPill(symptom: symptom, isSelected: selectedSymptoms.contains(symptom)) {
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
                }
                .padding(.top, 10)

                // Bouton "Soumettre"
                Button(action: {
                    print("Symptômes sélectionnés : \(selectedSymptoms)")
                }) {
                    Text("Soumettre")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                .padding(.bottom, 30) // Ajouter un espace à la fin de la page
            }
        }
        .background(Color(.systemGray5).edgesIgnoringSafeArea(.all))
    }
}

struct BabySymptomPill: View { // Renamed to avoid conflicts
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

struct BabySymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        BabySymptomsView()
    }
}
