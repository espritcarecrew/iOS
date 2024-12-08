import SwiftUI

struct BloodPressureGuideView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Top bar with close button
                HStack {
                    Spacer()
                    Button(action: {
                        print("Fermer la vue")
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding(.top, 10)

                // Illustration image
                Image("blood_pressure_illustration") // Remplacez par le nom de votre image dans Assets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.horizontal, 20)

                // Main title
                Text("Comment bien prendre votre pression artérielle")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    .padding(.top, 20)

                // Instructions list
                VStack(alignment: .leading, spacing: 15) {
                    GuideStepView(step: "1", text: "Asseyez-vous correctement, les deux pieds à plat sur le sol.")
                    GuideStepView(step: "2", text: "Posez votre bras avec le brassard sur une table.")
                    GuideStepView(step: "3", text: "Détendez-vous quelques minutes.")
                    GuideStepView(step: "4", text: "Ne parlez pas pendant la mesure de tension.")
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Spacer()

                // Button
                NavigationLink(destination: BloodPressureInputView()) {
                    Text("D’accord")
                        .font(.headline)
                        .foregroundColor(.white)
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
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 20)
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}

// Subview for each instruction step
struct GuideStepView: View {
    let step: String
    let text: String

    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(Color.purple)
                .frame(width: 30, height: 30)
                .overlay(
                    Text(step)
                        .font(.headline)
                        .foregroundColor(.white)
                )
            
            Text(text)
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.leading, 10)
        }
    }
}


struct BloodPressureGuideView_Previews: PreviewProvider {
    static var previews: some View {
        BloodPressureGuideView()
    }
}
