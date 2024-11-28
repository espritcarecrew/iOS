//
//  Questionsview.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 28/11/2024.
//
import SwiftUI

struct Pregnancy: View {
    @State private var searchText: String = "" // For the search bar
    @State private var selectedSymptoms: Set<String> = [] // Tracks selected symptoms

    let symptomsData = [
        "General": ["nothing", "fatigue/exhaustion", "morning sickness", "shortness of breath", "cold/flu symptoms", "stretch marks"],
        "Head & neck": ["headaches", "acne", "dizziness", "vision changes", "neckaches", "bleeding gums/nose"],
        "Chest & back": ["tender breasts", "backaches", "breast pain", "heartburn", "nipple soreness", "breast engorgement"],
        "Stomach/gastrointestinal": ["bloating", "abdominal aches & pains", "stomachache", "constipation", "appetite increase", "appetite decrease", "flatulence", "cravings", "aversions"]
    ]

    var body: some View {
        VStack(spacing: 0) {

            // Section Title
            HStack(spacing: 10) {
                Image(systemName: "stethoscope")
                    .foregroundColor(.blue)
                Text("symptoms")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            // Subtitle
            Text("What's your body telling you?")
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
            
            // Symptoms List
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
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
                                    SymptomPill(symptom: symptom, isSelected: selectedSymptoms.contains(symptom)) {
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
            }
        }
        .background(Color(.systemGray5).edgesIgnoringSafeArea(.all))
    }
}

struct SymptomPill: View {
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

struct SymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        Pregnancy()
    }
}

