import SwiftUI

struct DailyArticlesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Image
            Image("daily_articles") // Remplacez par le nom de votre image dans Assets
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)

            // Title
            Text("Articles quotidiens")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)

            // Description
            Text("Lisez des articles quotidiens et tenez-vous au courant de la grossesse et du processus de conception.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Spacer()

            // Button
            NavigationLink(destination: PregnancyTrackerView()) {
                Text("Début")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(Color("PeachBackground")) // Remplacez par votre couleur de fond
        .edgesIgnoringSafeArea(.all)
    }
}


struct DailyArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DailyArticlesView()
        }
    }
}


