//
//  homepage.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 26/11/2024.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top Navigation Bar
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 24))
                    .foregroundColor(.purple)
                Spacer()
                Text("baby journey")
                    .font(.custom("System", size: 18))
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "bell")
                    .font(.system(size: 24))
                    .foregroundColor(.purple)
            }
            .padding()
            .background(Color("PeachBackground"))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Lock Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.yellow.opacity(0.3))
                            .frame(height: 200)
                        
                        VStack {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.purple)
                            Text("Curious about what's hiding here?")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.purple)
                            Text("Create a free account to unlock the content!")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.purple.opacity(0.7))
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Popular Content Section
                    Text("Popular content in week 3")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        // Content Card 1
                        ContentCard(imageName: "pregnancy1", title: "How hormones affect you during pregnancy")
                        
                        // Content Card 2
                        ContentCard(imageName: "pregnancy2", title: "Bleeding during pregnancy, what does it mean?")
                        
                        // Add more cards as needed...
                    }
                    .padding(.horizontal)
                }
            }
            
            // Bottom Tab Bar
            HStack {
                TabBarItem(iconName: "house.fill", title: "Home", isActive: true)
                TabBarItem(iconName: "magnifyingglass", title: "Content", isActive: false)
                TabBarItem(iconName: "wrench.fill", title: "Tools", isActive: false)
            }
            .padding()
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
    }
}

struct ContentCard: View {
    let imageName: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(title)
                .font(.headline)
                .foregroundColor(.purple)
            
            Spacer()
            
            Image(systemName: "doc.text")
                .foregroundColor(.purple)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct TabBarItem: View {
    let iconName: String
    let title: String
    let isActive: Bool
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(isActive ? .purple : .gray)
            Text(title)
                .font(.caption)
                .foregroundColor(isActive ? .purple : .gray)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

