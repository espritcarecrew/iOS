import SwiftUI

struct VaccinationInputView: View {
    @State private var babyName: String = ""
    @State private var vaccineDate: Date = Date()
    @State private var vaccineType: String = "BCG"
    @State private var saveMessage: String = "Aucune donnée sauvegardée pour l'instant"

    let vaccineOptions = [
        "BCG",
        "Hépatite B (première dose)",
        "Diphtérie",
        "Tétanos",
        "Polio (inactivée)",
        "Hépatite B (deuxième dose)",
        "Rotavirus",
        "ROR"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Détails de la vaccination")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                        .padding(.top)

                    Group {
                        CustomTextField(placeholder: "Nom du bébé", text: $babyName)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Date du vaccin")
                                .font(.headline)
                                .foregroundColor(.gray)

                            DatePicker("", selection: $vaccineDate, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Type de vaccin")
                                .font(.headline)
                                .foregroundColor(.gray)

                            Picker("Type de vaccin", selection: $vaccineType) {
                                ForEach(vaccineOptions, id: \ .self) { option in
                                    Text(option).tag(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        }
                    }

                    Button(action: {
                        saveVaccination()
                    }) {
                        Text("Enregistrer")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    Text(saveMessage)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Vaccination")
        }
    }

    private func saveVaccination() {
        guard !babyName.isEmpty else {
            saveMessage = "Veuillez entrer le nom du bébé."
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: vaccineDate)

        guard let url = URL(string: "http://localhost:3000/vaccination") else {
            saveMessage = "URL invalide."
            return
        }

        let parameters: [String: Any] = [
            "babyName": babyName,
            "vaccineDate": formattedDate,
            "vaccineType": vaccineType
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            saveMessage = "Erreur de sérialisation des données."
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    saveMessage = "Erreur réseau : \(error.localizedDescription)"
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    saveMessage = "Erreur serveur : Réponse invalide."
                }
                return
            }

            DispatchQueue.main.async {
                saveMessage = "Vaccination enregistrée avec succès."
            }
        }.resume()
    }
}


struct VaccinationInputView_Previews: PreviewProvider {
    static var previews: some View {
        VaccinationInputView()
    }
}
