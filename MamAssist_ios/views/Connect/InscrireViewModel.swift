import SwiftUI

struct InscrireViewModel: View {
    @State private var currentIndex: Int = 0 // Track the currently displayed image
    @State private var isLoggedIn: Bool = false

    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            
            // TabView for sliding images
            TabView(selection: $currentIndex) {
                OnboardingImageView(imageName: "pregnancy_image", tag: 0)
                OnboardingImageView(imageName: "medical_network", tag: 1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide pagination dots
            .frame(height: 500)
            
            // Main text
            Text(currentIndex == 0
                 ? "Enregistrez vos symptômes et mesures dans votre passeport de grossesse"
                 : "Ayez recours à un suivi médical personnalisé de votre grossesse")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .foregroundColor(.black)
            
            Spacer()
            
            // Pagination indicators
            PaginationIndicator(currentIndex: $currentIndex, pageCount: 2)
            
            Spacer()
            
            // Signup Button
            NavigationLink(destination: SignupView().navigationBarBackButtonHidden(true)) {
                Text("S'inscrire")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            // Login Link
            HStack {
                Text("Déjà inscrite ?")
                    .foregroundColor(.gray)
                NavigationLink(destination: LoginViewWithAssetImage().navigationBarBackButtonHidden(true)) {
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
        .navigationBarBackButtonHidden(true) // Remove back button globally for this view
    }
}

struct OnboardingImageView: View {
    let imageName: String
    let tag: Int

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .tag(tag) // Track the TabView index
    }
}

struct PaginationIndicator: View {
    @Binding var currentIndex: Int
    let pageCount: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? Color.pink : Color.gray.opacity(0.5))
                    .frame(width: 10, height: 10)
            }
        }
    }
}

struct InscrireViewModel_Previews: PreviewProvider {
    static var previews: some View {
        InscrireViewModel()
    }
}
