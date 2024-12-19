import SwiftUI

struct BloodPressureInputView: View {
    @State private var age: String = ""
    @State private var systolicPressure: String = ""
    @State private var diastolicPressure: String = ""
    @State private var bloodSugar: String = ""
    @State private var bodyTemperature: String = ""
    @State private var heartRate: String = ""
    @State private var result: String = "Aucun résultat pour l'instant"
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @AppStorage("history") private var history: String = ""

    var body: some View {
        VStack {
            // Navigation bar
            HStack {
                Spacer()

                Text("Tension")
                    .font(.headline)
                    .foregroundColor(.black)
                    

                Spacer()

                NavigationLink(destination: HistoryView(history: history)) {
                    Text("Antécédents")
                        .font(.headline)
                        .foregroundColor(.purple)
                }
            }
            .padding(.vertical)

            // Title
            Text("Quelle est votre tension artérielle actuelle ?")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.pink)
                .padding(.horizontal, 20)

            Spacer().frame(height: 30)

            // Input fields
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    Text("Quelle est votre HealthPrediction ?")
                        .font(.headline)
                        .foregroundColor(.pink)
                        .padding(.top)

                    Group {
                        CustomTextField(placeholder: "Âge", text: $age)
                        CustomTextField(placeholder: "Pression Systolique", text: $systolicPressure)
                        CustomTextField(placeholder: "Pression Diastolique", text: $diastolicPressure)
                        CustomTextField(placeholder: "BS", text: $bloodSugar)
                        CustomTextField(placeholder: "Température Corporelle", text: $bodyTemperature)
                        CustomTextField(placeholder: "Fréquence Cardiaque", text: $heartRate)
                    }
                }
            }
            .padding(.horizontal, 20)

            Spacer()

            // Save button
            Button(action: {
                submitForm()
            }) {
                Text("Enregistrer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Données reçues"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

    private func submitForm() {
        guard let url = URL(string: "http://localhost:3000/predictions"),
              let ageValue = Int(age),
              let systolicBPValue = Int(systolicPressure),
              let diastolicBPValue = Int(diastolicPressure),
              let bloodSugarValue = Double(bloodSugar),
              let bodyTempValue = Double(bodyTemperature),
              let heartRateValue = Int(heartRate) else {
            DispatchQueue.main.async {
                alertMessage = "Veuillez remplir tous les champs correctement."
                showAlert = true
            }
            return
        }

        let parameters: [String: Any] = [
            "age": ageValue,
            "systolicBP": systolicBPValue,
            "diastolicBP": diastolicBPValue,
            "bs": bloodSugarValue,
            "bodyTemp": bodyTempValue,
            "heartRate": heartRateValue
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            DispatchQueue.main.async {
                alertMessage = "Erreur de sérialisation des données."
                showAlert = true
            }
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Erreur réseau : \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    alertMessage = "Erreur serveur : Réponse invalide."
                    showAlert = true
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    alertMessage = "Aucune réponse du serveur."
                    showAlert = true
                }
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let riskLevel = jsonResponse["riskLevel"] as? String {
                    DispatchQueue.main.async {
                        alertMessage = "Niveau de risque : \(riskLevel)"
                        let newEntry = "Âge: \(ageValue), Systolique: \(systolicBPValue), Diastolique: \(diastolicBPValue), BS: \(bloodSugarValue), Température: \(bodyTempValue), Fréquence: \(heartRateValue), Risque: \(riskLevel)\n"
                        history += newEntry
                        showAlert = true
                    }
                } else {
                    DispatchQueue.main.async {
                        alertMessage = "Réponse inattendue."
                        showAlert = true
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    alertMessage = "Erreur lors de la lecture de la réponse."
                    showAlert = true
                }
            }
        }.resume()
    }
}

struct HistoryView: View {
    let history: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if history.isEmpty {
                    Text("Aucun antécédent enregistré.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(history.split(separator: "\n"), id: \.self) { entry in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry)
                                .font(.body)
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.pink.opacity(0.2)]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ))
                                )
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.top, 10)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationTitle("Antécédents")
    }
}

struct BloodPressureInputView_Previews: PreviewProvider {
    static var previews: some View {
        BloodPressureInputView()
    }
}
