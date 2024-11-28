import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0 // Tracks the currently selected tab

    var body: some View {
        VStack(spacing: 0) {
            // Display the content based on the selected tab
            Group {
                if selectedTab == 0 {
                    HomeView()
                } else if selectedTab == 1 {
                    ToolsView()
                } else if selectedTab == 2 {
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom Navigation Bar
            CustomNavigationBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom) // Ensures the custom nav bar is fully visible
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
