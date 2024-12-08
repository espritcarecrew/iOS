import SwiftUI

struct DiscussionView: View {
    var body: some View {
        
        VStack {
            // Header
            HStack {
                Text("Bonjour,")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.leading, 16)

                Spacer()
            }
            .padding(.top, 20)

            Text("Notre équipe médicale répond à toutes vos questions liées à la grossesse et au post-partum sous 48 h")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
                .padding(.top, 8)

            Spacer()

            // Main text and button
            VStack {
                Text("Démarrer une nouvelle conversation avec un professionnel de santé")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                Spacer().frame(height: 20)

                Button(action: {
                    print("Poser votre question button tapped")
                }) {
                    HStack {
                        Image(systemName: "message.fill")
                            .foregroundColor(.white)

                        Text("Poser votre question")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.pink]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
                .padding(.horizontal, 16)
            }

            Spacer()

            // Tab bar
        }    }    }

struct DiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionView()
    }
}
//
//  DiscussionView.swift
//  MamAssist_ios
//
//  Created by med karim checambou on 7/12/2024.
//

