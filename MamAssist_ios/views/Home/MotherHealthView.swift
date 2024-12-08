import SwiftUI

struct MotherHealthView: View {
    @State private var searchText: String = "" // Barre de recherche
    @State private var selectedQuestions: Set<String> = [] // Questions sélectionnées

    let healthQuestionsData = [
        "Général": ["Diabète", "Hypertension", "Anémie", "Asthme", "Infections bactériennes", "Problèmes hormonaux"],
        "Maladies transmissibles": ["Hépatite B", "Hépatite C", "Tuberculose", "VIH/SIDA", "Maladies sexuellement transmissibles"],
        "Allergies et intolérances": ["Intolérance au lactose", "Allergie alimentaire", "Allergie respiratoire", "Eczéma"],
        "Antécédents familiaux": ["Problèmes cardiaques", "Cancers héréditaires", "Maladies génétiques"]
    ]

    var body: some View {
        NavigationStack { // Use NavigationStack to enable navigation
            ScrollView {
                VStack(spacing: 0) {
                    // Titre principal
                    HStack(spacing: 10) {
                        Image(systemName: "heart.text.square.fill")
                            .foregroundColor(.pink)
                        Text("Santé et Maladies")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Sous-titre
                    Text("Quelle est votre santé et quelles maladies peuvent être transmises à votre bébé ?")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    // Barre de recherche
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Rechercher une question", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(8)
                    }
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray6))
                    )
                    .padding(.horizontal)
                    
                    // Liste des questions
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(healthQuestionsData.keys.sorted(), id: \.self) { section in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(section)
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                
                                // Boutons de type "pill" pour les questions
                                let questions = healthQuestionsData[section] ?? []
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                    ForEach(questions, id: \.self) { question in
                                        HealthQuestionPill(question: question, isSelected: selectedQuestions.contains(question)) {
                                            if selectedQuestions.contains(question) {
                                                selectedQuestions.remove(question)
                                            } else {
                                                selectedQuestions.insert(question)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 10)

                    // Bouton "Ajouter votre bébé"
                    NavigationLink(destination: SymptomsForMomsView()) {
                        Text("Ajouter votre bébé")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pink)
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
}

struct HealthQuestionPill: View {
    let question: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(question)
                    .font(.footnote)
                    .foregroundColor(isSelected ? .white : .pink)
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
                    .fill(isSelected ? Color.pink : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.pink, lineWidth: 1)
                    )
            )
        }
    }
}

struct MotherHealthView_Previews: PreviewProvider {
    static var previews: some View {
        MotherHealthView()
    }
}
