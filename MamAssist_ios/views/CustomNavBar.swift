import SwiftUI

struct CustomNavBar: View {
    @Binding var selectedTab: Int // Binding to control the selected tab index

    var body: some View {
        HStack {
            CustomNavBarButton(
                title: "Accueil",
                systemImage: "house.fill",
                isSelected: selectedTab == 0 // Vérifie si c'est le bouton actif
            ) {
                selectedTab = 0
            }

            Spacer()

            CustomNavBarButton(
                title: "Discussions",
                systemImage: "bubble.left.and.bubble.right.fill", // Correction de l'icône
                isSelected: selectedTab == 1 // Vérifie si c'est le bouton actif
            ) {
                selectedTab = 1
            }
            Spacer()

            CustomNavBarButton(
                title: "Doctors",
                systemImage: "", // Correction de l'icône
                isSelected: selectedTab == 2 // Vérifie si c'est le bouton actif
            ) {
                selectedTab = 2
            }
            Spacer()

            CustomNavBarButton(
                title: "Tools",
                systemImage: "wrench.and.screwdriver",
                isSelected: selectedTab == 3 // Vérifie si c'est le bouton actif
            ) {
                selectedTab = 3
            }
        }
        .padding()
        .background(Color.white.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2))
    }
}

struct CustomNavBarButton: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(isSelected ? .purple : .gray)

                Text(title)
                    .font(.footnote)
                    .foregroundColor(isSelected ? .purple : .gray)
            }
        }
    }
}
