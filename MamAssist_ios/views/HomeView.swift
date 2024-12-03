import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0 // Current selected tab for custom navigation

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("resetpass")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    modernAppBar

                    // Display the content based on the selected tab
                    Group {
                        if selectedTab == 0 {
                            homeContentView // Core content of HomeView
                        } else if selectedTab == 1 {
                            ToolsView() // Navigates to ToolsView
                        } else if selectedTab == 2 {
                            ProfileView() // Navigates to ProfileView
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    // Custom Navigation Bar (handles switching between views)
                    CustomNavigationBar(selectedTab: $selectedTab)
                }
                .edgesIgnoringSafeArea(.bottom)
                .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
            }
        }
    }
    private var modernAppBar: some View {
        ZStack {
            // Blurry white background
            Color.white.opacity(0.8)
                .blur(radius: 40)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100) // App bar height

            HStack {
                // Left Icon
                

                Spacer()

                // App Title
                Text("MamAssist")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)

                Spacer()

                // Right Icon
                Image(systemName: "bell")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.purple)
                    .padding(.trailing, 16)
            }
        }
    }
    // Core Content View for HomeView
    private var homeContentView: some View {
        VStack(spacing: 0) {
            // Top Header Bar
            HStack {
               
                
            }
            .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // Lock Card Section - Horizontally Scrollable Cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            // Card 1
                            NavigationLink(destination: DetailView(imageName: "article1", title: "Importance du sport", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu felis ullamcorper, malesuada mauris in, ultricies lacus. Sed condimentum blandit lectus quis eleifend. Mauris efficitur odio sed ligula semper, vitae elementum libero rutrum. Fusce cursus,  tellus vel lobortis tempus, turpis mi mattis mi, sed ullamcorper libero nibh et augue. Cras gravida vel magna ac egestas. Etiam est eros, posuere eget dui tincidunt, ullamcorper venenatis tortor. Duis gravida justo pharetra nisl pharetra volutpat. Mauris in est non justo tincidunt volutpat. Vestibulum sollicitudin iaculis mauris. Etiam tempus sapien sit amet orci rutrum, non tristique nisl elementum. Phasellus posuere sapien nec purus consectetur gravida. Sed est purus, tincidunt non lacinia sed, lacinia sed enim. Vestibulum ultrices mollis massa quis tincidunt. Sed volutpat vel mauris non tincidunt. Duis tempor eu est at lacinia. Integer maximus lacus quis porttitor faucibus. Pellentesque dictum cursus odio, ac faucibus libero. Etiam vel sem at lorem egestas finibus.")) {
                                CardView(color: Color.gray.opacity(0.3), imageName: "info.bubble", title: "Complete your information", subtitle: "Create a free account to unlock the content!")
                            }

                            NavigationLink(destination: DetailView(imageName: "article2", title: "Naussée", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu felis ullamcorper, malesuada mauris in, ultricies lacus. Sed condimentum blandit lectus quis eleifend. Mauris efficitur odio sed ligula semper, vitae elementum libero rutrum. Fusce cursus, tellus vel lobortis tempus, turpis mi mattis mi, sed ullamcorper libero nibh et augue. Cras gravida vel magna ac egestas. Etiam est eros, posuere eget dui tincidunt, ullamcorper venenatis tortor. Duis gravida justo pharetra nisl pharetra volutpat. Mauris in est non justo tincidunt volutpat. Vestibulum sollicitudin iaculis mauris. Etiam tempus sapien sit amet orci rutrum, non tristique nisl elementum. Phasellus posuere sapien nec purus consectetur gravida.Sed est purus, tincidunt non lacinia sed, lacinia sed enim. Vestibulum ultrices mollis massa quis tincidunt. Sed volutpat vel mauris non tincidunt. Duis tempor eu est at lacinia. Integer maximus lacus quis porttitor faucibus. Pellentesque dictum cursus odio, ac faucibus libero. Etiam vel sem at lorem egestas finibus.")) {
                                CardView(color: Color.gray.opacity(0.3), imageName: "info.bubble", title: "Complete your information", subtitle: "Create a free account to unlock the content!")
                            }

                            NavigationLink(destination: DetailView(imageName: "article3", title: "Importance de l'eau", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu felis ullamcorper, malesuada mauris in, ultricies lacus. Sed condimentum blandit lectus quis eleifend. Mauris efficitur odio sed ligula semper, vitae elementum libero rutrum. Fusce cursus, tellus vel lobortis tempus, turpis mi mattis mi, sed ullamcorper libero nibh et augue. Cras gravida vel magna ac egestas. Etiam est eros, posuere eget dui tincidunt, ullamcorper venenatis tortor. Duis gravida justo pharetra nisl pharetra volutpat. Mauris in est non justo tincidunt volutpat. Vestibulum sollicitudin iaculis mauris. Etiam tempus sapien sit amet orci rutrum, non tristique nisl elementum. Phasellus posuere sapien nec purus consectetur gravida.Sed est purus, tincidunt non lacinia sed, lacinia sed enim. Vestibulum ultrices mollis massa quis tincidunt. Sed volutpat vel mauris non tincidunt. Duis tempor eu est at lacinia. Integer maximus lacus quis porttitor faucibus. Pellentesque dictum cursus odio, ac faucibus libero. Etiam vel sem at lorem egestas finibus.")) {
                                CardView(color: Color.gray.opacity(0.3), imageName: "info.bubble", title: "Complete your information", subtitle: "Create a free account to unlock the content!")
                            }

                            NavigationLink(destination: DetailView(imageName: "article4", title: "Alimentation", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu felis ullamcorper, malesuada mauris in, ultricies lacus. Sed condimentum blandit lectus quis eleifend. Mauris efficitur odio sed ligula semper, vitae elementum libero rutrum. Fusce cursus, tellus vel lobortis tempus, turpis mi mattis mi, sed ullamcorper libero nibh et augue. Cras gravida vel magna ac egestas. Etiam est eros, posuere eget dui tincidunt, ullamcorper venenatis tortor. Duis gravida justo pharetra nisl pharetra volutpat. Mauris in est non justo tincidunt volutpat. Vestibulum sollicitudin iaculis mauris. Etiam tempus sapien sit amet orci rutrum, non tristique nisl elementum. Phasellus posuere sapien nec purus consectetur gravida.Sed est purus, tincidunt non lacinia sed, lacinia sed enim. Vestibulum ultrices mollis massa quis tincidunt. Sed volutpat vel mauris non tincidunt. Duis tempor eu est at lacinia. Integer maximus lacus quis porttitor faucibus. Pellentesque dictum cursus odio, ac faucibus libero. Etiam vel sem at lorem egestas finibus.")) {
                                CardView(color: Color.gray.opacity(0.3), imageName: "info.bubble", title: "Complete your information", subtitle: "Create a free account to unlock the content!")
                            }

                            // Card 2
                            NavigationLink(destination: DetailView(imageName: "article5", title: "Baby Blues", description: "LLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu felis ullamcorper, malesuada mauris in, ultricies lacus. Sed condimentum blandit lectus quis eleifend. Mauris efficitur odio sed ligula semper, vitae elementum libero rutrum. Fusce cursus, tellus vel lobortis tempus, turpis mi mattis mi, sed ullamcorper libero nibh et augue. Cras gravida vel magna ac egestas. Etiam est eros, posuere eget dui tincidunt, ullamcorper venenatis tortor. Duis gravida justo pharetra nisl pharetra volutpat. Mauris in est non justo tincidunt volutpat. Vestibulum sollicitudin iaculis mauris. Etiam tempus sapien sit amet orci rutrum, non tristique nisl elementum. Phasellus posuere sapien nec purus consectetur gravida.Sed est purus, tincidunt non lacinia sed, lacinia sed enim. Vestibulum ultrices mollis massa quis tincidunt. Sed volutpat vel mauris non tincidunt. Duis tempor eu est at lacinia. Integer maximus lacus quis porttitor faucibus. Pellentesque dictum cursus odio, ac faucibus libero. Etiam vel sem at lorem egestas finibus.")) {
                                CardView(color: Color.gray.opacity(0.3), imageName: "lock.shield", title: "Secure Your Profile", subtitle: "Add additional security settings!")
                            }
                        }
                        .padding(.horizontal)
                    }

                    // **New Button: "What Happens in Months"**
                    NavigationLink(destination: MonthsView()) {
                        ActionButton(title: "What Happens in Months", iconName: "calendar")
                            .padding(.horizontal)
                    }

                    // Spacer or Padding for separation
                

                    VStack(spacing: 12) {
                        // Content Card 1
                        NavigationLink(destination: DetailView(imageName: "pregnancy1", title: "Hormonal Changes", description: "How hormones affect you during pregnancy.")) {
                            ContentCard(imageName: "pregnancy1", title: "How hormones affect you during pregnancy")
                        }
                        .padding(.vertical)

                        // Content Card 2
                        NavigationLink(destination: DetailView(imageName: "pregnancy2", title: "Bleeding During Pregnancy", description: "Bleeding during pregnancy, what does it mean?")) {
                            ContentCard(imageName: "pregnancy2", title: "Bleeding during pregnancy, what does it mean?")
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct CardView: View {
    let color: Color
    let imageName: String
    let title: String
    let subtitle: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .frame(width: 300, height: 300)
            VStack {
                Image(systemName: imageName)
                    .font(.system(size: 50))
                    .foregroundColor(.purple)
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.purple)
                Text(subtitle)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.purple.opacity(0.8))
            }
            .padding()
        }
    }
}

struct ContentCard: View {
    let imageName: String
    let title: String

    var body: some View {
        HStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(title)
                .font(.headline)
                .foregroundColor(.purple)

            Spacer()

            Image(systemName: "doc.text")
                .foregroundColor(.purple)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct ActionButton: View {
    let title: String
    let iconName: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.purple)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

struct MonthssView: View {
    var body: some View {
        VStack {
            // Example content for MonthsView
            Text("What Happens in Months")
                .font(.largeTitle)
                .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(1...12, id: \.self) { month in
                        MonthDetailView(month: month)
                    }
                }
                .padding()
            }

            Spacer()
        }
        .navigationBarTitle("Monthly Overview", displayMode: .inline)
    }
}

struct MonthDetailView: View {
    let month: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Month \(month)")
                .font(.headline)
                .foregroundColor(.purple)

            Text("Details about what happens in month \(month). Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light Mode")
            HomeView()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
