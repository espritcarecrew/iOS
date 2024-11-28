import SwiftUI

struct Firstpage: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("firstpage") // Replace with your image name
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea() // Extend the image to the edges of the screen

                VStack(spacing: 50) {
                    Spacer()

                    // Title
                    Text("Hey, who are you?")
                        .font(.largeTitle)
                        .foregroundColor(.purple)
                        .padding(.bottom, 40)

                    Spacer()

                    // "I'm Pregnant" Button
                    NavigationLink(destination: Pregnancy()) {
                        HStack {
                            Image(systemName: "figure.stand.dress")
                                .foregroundColor(.purple)
                            Text("I'm pregnant")
                                .foregroundColor(.purple)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.purple)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.purple, lineWidth: 1)
                        )
                    }

                    // "I Have Children" Button
                    NavigationLink(destination: MotherHealthView()) {
                        HStack {
                            Image(systemName: "figure.and.child.holdinghands")
                                .foregroundColor(.purple)
                            Text("I have children")
                                .foregroundColor(.purple)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.purple)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.purple, lineWidth: 1)
                        )
                    }

                    Spacer()

                    // Links
                    VStack(spacing: 10) {
                        NavigationLink(destination: Loginpage()) {
                            Text("I have an account / Login")
                                .foregroundColor(.purple)
                                .underline()
                        }

                        NavigationLink(destination: HomeView()) {
                            Text("Test app without creating an account")
                                .foregroundColor(.purple)
                                .underline()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 30)

                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true) // Completely hides the navigation bar
            .navigationBarBackButtonHidden(true) // Hides the back button
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Prevents redundant navigation views
    }
}

// Preview
struct Firstpage_Previews: PreviewProvider {
    static var previews: some View {
        Firstpage()
    }
}
