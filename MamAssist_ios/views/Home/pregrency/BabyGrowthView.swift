import SwiftUI

struct BabyGrowthView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Image
            Image("baby_growth") // Remplacez par le nom de votre image dans Assets
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 500)

            // Title
            Text("Croissance du bébé")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)

            // Description
            Text("Connaître la croissance de votre bébé est sûr et facile dans le ventre de la mère.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Spacer()

            // Pagination indicators
            HStack {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 20, height: 20)
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 20, height: 20)
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 20, height: 20)
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 20, height: 20)
                }
                Spacer()

                // Navigate to PregnancyToolsView
                NavigationLink(destination: PregnancyToolsView()) {
                    Image(systemName: "arrow.forward")
                        .foregroundColor(.purple)
                        .font(.title)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .background(Color("PeachBackground")) // Remplacez par votre couleur de fond
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}



struct BabyGrowthView_Previews: PreviewProvider {
    static var previews: some View {
        BabyGrowthView()
    }
}

// Previews

