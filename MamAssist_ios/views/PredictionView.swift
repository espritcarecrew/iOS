//
//  PredictionView.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 19/12/2024.
//

import SwiftUI

struct PredictionView: View {
    @State private var age: String = ""
    @State private var systolicPressure: String = ""
    @State private var diastolicPressure: String = ""
    @State private var bloodSugar: String = ""
    @State private var bodyTemperature: String = ""
    @State private var heartRate: String = ""
    @State private var result: String = "Aucun résultat pour l'instant"

    var body: some View {
        NavigationView {
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

                Button(action: {
                    submitForm()
                }) {
                    Text("Envoyer")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20)

                Text(result)
                    .foregroundColor(.gray)
                    .padding(.top, 20)

                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("HealthPrediction")
        }
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
                result = "Veuillez remplir tous les champs correctement."
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
                result = "Erreur de sérialisation des données."
            }
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    result = "Erreur réseau : \(error.localizedDescription)"
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    result = "Erreur serveur : Réponse invalide."
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    result = "Aucune réponse du serveur."
                }
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let riskLevel = jsonResponse["riskLevel"] as? String {
                    DispatchQueue.main.async {
                        result = "Niveau de risque : \(riskLevel)"
                    }
                } else {
                    DispatchQueue.main.async {
                        result = "Réponse inattendue."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    result = "Erreur lors de la lecture de la réponse."
                }
            }
        }.resume()
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.vertical, 5)
    }
}

#Preview {
    PredictionView()
}
