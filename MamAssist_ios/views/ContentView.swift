//
//  ContentView.swift
//  test
//
//  Created by med karim checambou on 14/11/2024.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            InscrireViewModel()
                .navigationBarHidden(true)
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

