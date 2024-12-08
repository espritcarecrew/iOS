import SwiftUI

struct InscrireViewModel: View {
    @State private var currentIndex: Int = 0 // Pour suivre l'image affichée

    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 20)

                // TabView pour défiler entre les images
                TabView(selection: $currentIndex) {
                    Image("pregnancy_image") // Remplacez par le nom de votre première image
                        .resizable()
                        .scaledToFit()
                        .tag(0) // Identifiant pour le suivi de l'index

                    Image("medical_network") // Remplacez par le nom de votre deuxième image
                        .resizable()
                        .scaledToFit()
                        .tag(1) // Identifiant pour le suivi de l'index
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Cache les points de pagination natifs
                .frame(height: 500)

                // Texte principal
                Text(currentIndex == 0 ?
                     "Enregistrez vos symptômes et mesures dans votre passeport de grossesse" :
                     "Ayez recours à un suivi médical personnalisé de votre grossesse")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .foregroundColor(Color.black)

                Spacer()

                // Indicateurs de pagination
                HStack(spacing: 8) {
                    Circle()
                        .fill(currentIndex == 0 ? Color.pink : Color.gray.opacity(0.5))
                        .frame(width: 10, height: 10)
                    Circle()
                        .fill(currentIndex == 1 ? Color.pink : Color.gray.opacity(0.5))
                        .frame(width: 10, height: 10)
                }

                Spacer()

                // Bouton S'inscrire
                NavigationLink(destination: SignupView()) {
                    Text("S'inscrire")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                // Lien vers "Se connecter"
                HStack {
                    Text("Déjà inscrite ?")
                        .foregroundColor(.gray)
                    NavigationLink(destination: LoginViewWithAssetImage()) {
                        Text("Se connecter")
                            .foregroundColor(.pink)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 10)

                // Version
                Text("Version 1.21.2.686-prod")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)

                Spacer().frame(height: 20)
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}





struct MedicalFollowUpView_Previews: PreviewProvider {
    static var previews: some View {
        InscrireViewModel()
    }
}
