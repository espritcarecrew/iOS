import SwiftUI

struct SymptomsView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Button(action: {
                        // Action pour revenir en arrière
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.purple)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Text("Symptômes")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.purple)
                    
                    Spacer()
                    
                    Spacer() // Espace pour équilibrer
                }
                
                // Date Selector and History
                HStack {
                    Text("7 décembre")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.purple)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Historique")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                
                // Symptoms Sections
                ScrollView {
                    VStack(spacing: 30) {
                        SymptomsSection(title: "GÉNÉRAL", symptoms: [
                            Symptom(icon: "hand.thumbsup", label: "Tout va bien"),
                            Symptom(icon: "figure.walk", label: "Beaucoup d'activité"),
                            Symptom(icon: "zzz", label: "Épuisée"),
                            Symptom(icon: "lungs", label: "Œdème pieds/jambes"),
                            Symptom(icon: "bandage", label: "Démangeaisons de la peau")
                        ])
                        
                        SymptomsSection(title: "ZONE DU BASSIN", symptoms: [
                            Symptom(icon: "square.dashed", label: "Douleur dans le bassin"),
                            Symptom(icon: "exclamationmark.triangle", label: "Contractions utérines"),
                            Symptom(icon: "drop.fill", label: "Douleur en faisant pipi"),
                            Symptom(icon: "female", label: "Démangeaisons vulvaires"),
                            Symptom(icon: "drop.triangle.fill", label: "Perte de sang"),
                            Symptom(icon: "drop.fill", label: "Perte de liquide amniotique"),
                            Symptom(icon: "person.2", label: "Absence mouvements bébé > 12h")
                        ])
                        
                        SymptomsSection(title: "TÊTE", symptoms: [
                            Symptom(icon: "bolt", label: "Vertiges"),
                            Symptom(icon: "drop.fill", label: "Évanouissement"),
                            Symptom(icon: "cloud.rain", label: "Symptômes rhume/grippe"),
                            Symptom(icon: "headphones", label: "Maux de tête"),
                            Symptom(icon: "eye", label: "Petites 'mouches' devant les yeux"),
                            Symptom(icon: "ear", label: "Acouphènes")
                        ])
                        
                        SymptomsSection(title: "VENTRE OU ESTOMAC", symptoms: [
                            Symptom(icon: "sun.max", label: "Nausées du matin"),
                            Symptom(icon: "flame.fill", label: "Forte nausée toute la journée"),
                            Symptom(icon: "fork.knife", label: "Reflux gastro-œsophagien"),
                            Symptom(icon: "heart.fill", label: "Douleur dans l'estomac"),
                            Symptom(icon: "leaf", label: "Désordres digestifs")
                        ])
                    }
                }
                .padding(.horizontal)
                
                // Save Button
                Button(action: {
                    print("Enregistrer les symptômes")
                }) {
                    Text("Enregistrer les symptômes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
    }
}

struct SymptomsSection: View {
    let title: String
    let symptoms: [Symptom]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(symptoms, id: \.id) { symptom in
                        SymptomView(symptom: symptom)
                    }
                }
            }
        }
    }
}

struct SymptomView: View {
    let symptom: Symptom
    @State private var isSelected = false
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            VStack {
                Image(systemName: symptom.icon)
                    .font(.system(size: 40))
                    .foregroundColor(isSelected ? .white : .purple)
                    .padding()
                    .background(isSelected ? Color.purple : Color.gray.opacity(0.2))
                    .clipShape(Circle())
                
                Text(symptom.label)
                    .font(.footnote)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 80)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct Symptom: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
}

struct SymptomsView_Previewsss: PreviewProvider {
    static var previews: some View {
        SymptomsView()
    }
}
