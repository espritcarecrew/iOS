//
//  ContentView.swift
//  test
//
//  Created by med karim checambou on 14/11/2024.
//
import SwiftUI

struct ContentView: View {
    // Replace with actual default values or user data
    @State private var defaultValues: String? = UserDefaults.standard.string(forKey: "userEmail") // Example

    var body: some View {
        NavigationView {
            if let values = defaultValues, !values.isEmpty {
                HomeView() // Navigate to HomeView if defaultValues are not empty
                
            } else {
                InscrireViewModel() // Navigate to InscrireViewModel if defaultValues are empty
            }
        }
        .navigationBarHidden(true)
    }
}

