import SwiftUI

struct BloodPressureInputView: View {
    @State private var systolic: String = "120 mmHg"
    @State private var diastolic: String = "80 mmHg"

    var body: some View {
        VStack {
            // Navigation bar
            HStack {
                Button(action: {
                    print("Back button tapped")
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.purple)
                        .padding(.leading)
                }

                Spacer()

                Text("Tension")
                    .font(.headline)
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(.vertical)

            // Tab bar
            HStack {
                Text("6 décembre")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .padding(.bottom, 4)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.purple),
                        alignment: .bottom
                    )

                Spacer()

                Text("Antécédents")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            Spacer().frame(height: 20)

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
                VStack(alignment: .leading, spacing: 8) {
                    Text("Systolique (Grand nombre)")
                        .font(.subheadline)
                        .foregroundColor(Color.pink)

                    TextField("120 mmHg", text: $systolic)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Diastolique (Petit nombre)")
                        .font(.subheadline)
                        .foregroundColor(Color.pink)

                    TextField("80 mmHg", text: $diastolic)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .padding(.horizontal, 20)

            Spacer()

            // Save button
            Button(action: {
                print("Tension enregistrée : \(systolic) / \(diastolic)")
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

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct BloodPressureInputView_Previews: PreviewProvider {
    static var previews: some View {
        BloodPressureInputView()
    }
}
//
//  BloodPressureInputView.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 7/12/2024.
//

