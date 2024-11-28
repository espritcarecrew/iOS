//
//  todoview.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 28/11/2024.
//
import SwiftUI

struct ToDoView: View {
    @State private var selectedCategory = 0 // Tracks the selected category (Pregnant, Child 0-1 years, Child 1-2 years)
    
    let categories = ["Pregnant", "Child 0-1 years", "Child 1-2 years"]
    let tasks = [
        ("My pregnancy test is positive! What do I do now?", 8),
        ("Preparing for childbirth", 6),
        ("Baby clothes", 10),
        ("The hospital bag for the baby", 9),
        ("The hospital bag for mom", 12)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Title and Description
            VStack(spacing: 10) {
                                
                Text("To do")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                
                Text("In these checklists there are tips and recommendations on what can be good to buy before the baby's arrival!")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(.purple.opacity(0.8))
                    .padding(.horizontal, 20)
            }
            .padding(.top, 20)
            
            // Segmented Control for Categories
            Picker("", selection: $selectedCategory) {
                ForEach(0..<categories.count) { index in
                    Text(categories[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Tasks Section
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(tasks, id: \.0) { task in
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green.opacity(0.3))
                                .frame(width: 8, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(task.0)
                                    .font(.headline)
                                    .foregroundColor(.purple)
                                
                                Text("0 of \(task.1) completed")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.purple)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
            }
        }
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all)) // Add "PeachBackground" in Assets
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}

