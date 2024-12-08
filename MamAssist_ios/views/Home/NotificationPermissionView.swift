import SwiftUI

struct NotificationPermissionView: View {
    @State private var navigateToHome = false // Variable d'état pour navigation

    var body: some View {
        NavigationView {
            VStack {
                // Top section with logo and "Ignorer" button
                HStack {
                    Spacer()
                    Button(action: {
                        navigateToHome = true
                    }) {
                        Text("Ignorer")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.trailing, 16)
                    }
                    .background(
                        NavigationLink("", destination: HomeView(), isActive: $navigateToHome)
                            .hidden()
                    )
                }
                .padding(.top, 20)

                // Logo
                Text("MamAssist")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 20)

                Spacer()

                // Notification illustration
                Image("notification_illustration") // Remplacez par le nom de votre image dans Assets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)

                Spacer()

                // Main text
                Text("Ne ratez aucun message des praticiens")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                Text("Autorisez les notifications afin d’être prévenue lorsqu’un praticien vous répond")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                Spacer()

                // Button to enable notifications
                Button(action: {
                    print("Notifications autorisées")
                }) {
                    Text("Autoriser les notifications")
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

                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}

struct NotificationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermissionView()
    }
}
