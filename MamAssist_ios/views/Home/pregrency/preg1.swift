import SwiftUI

struct PregnancyTrackingView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Image
                Image("pregnancy_tracking") // Remplacez par le nom de votre image dans Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)

                // Title
                Text("Suivi de grossesse")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                // Description
                Text("Suivi de grossesse pour suivre la grossesse et vous aider également à surveiller votre état de santé général.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal)

                Spacer()

                // Pagination dots and arrow
                HStack {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 20, height: 20)
                    }
                    Spacer()

                    // Navigation to BabyGrowthView
                    NavigationLink(destination: BabyGrowthView()) {
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct PregnancyTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        PregnancyTrackingView()
    }
}



