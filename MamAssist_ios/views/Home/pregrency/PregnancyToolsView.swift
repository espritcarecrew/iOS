import SwiftUI

struct PregnancyToolsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Image grid
            Image("pregnancy_tools") // Remplacez par le nom de votre image dans Assets
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 500)

            // Title
            Text("Outils de grossesse")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)

            // Description
            Text("Consultez nos outils pour une grossesse en santé. Les femmes peuvent être enceintes sans même le savoir !")
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
                        .fill(Color.gray)
                        .frame(width: 20, height: 20)
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 20, height: 20)
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 20, height: 20)
                }
                Spacer()

                // Navigate to DailyArticlesView
                NavigationLink(destination: DailyArticlesView()) {
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


struct PregnancyToolsView_Previews: PreviewProvider {
    static var previews: some View {
        PregnancyToolsView()
    }
}

