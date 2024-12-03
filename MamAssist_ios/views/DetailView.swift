import SwiftUI

struct DetailView: View {
    let imageName: String
    let title: String
    let description: String

    var body: some View {
        ZStack {
            // Background Image
            Image("resetpass")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Ensures the image covers the entire screen
            
            ScrollView { // Content inside a ScrollView
                VStack(spacing: 16) {
                    Spacer().frame(height: 50) // Spacer between the top of the screen and the image

                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.9) // Image fills 90% of screen width
                        .clipShape(RoundedRectangle(cornerRadius: 20)) // Optional: Rounded corners for a polished look

                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()

                    Text(description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Spacer()

                    Button(action: {
                        print("Ask Me button tapped by wiwiiiii")
                    }) {
                        Text("Ask Me")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding()
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            imageName: "info.bubble",
            title: "Example Title",
            description: "This is an example description for the DetailView. This description is long to demonstrate scrolling and text layout."
        )
    }
}
