//
//  ResponseView.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 16/12/2024.
//
import SwiftUI

struct ResponseView: View {
    let responseText: String

    var body: some View {
        VStack {
            Text("API Response")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            ScrollView {
                Text(responseText)
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.leading)
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding()

            Spacer()
        }
        .padding()
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
        .navigationTitle("Response")
        .navigationBarTitleDisplayMode(.inline)
    }
}
