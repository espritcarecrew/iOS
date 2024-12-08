import SwiftUI

struct ToolsView: View {
    let tools = [
        ("Checklist", "list.bullet"),
        ("Q&A", "questionmark.bubble"),
        ("Daily Mood", "face.smiling"),
        ("Pre-parenting Conversations", "gamecontroller"),
        ("Guides", "book"),
        ("Dietary Advice", "fork.knife"),
        ("Birth plan", "envelope.fill"),
        ("White Noise", "music.note"),
        ("Eye color calculator", "eye")
    ]
    
    // Image Carousel Data
    let images = ["etat", "check", "baby3"] // Replace with your image asset names
    @State private var currentImageIndex = 0 // Tracks the current image index

    var body: some View {
        NavigationStack { // Ensure NavigationStack is present
            VStack(spacing: 20) {
                ScrollView {
                    VStack(spacing: 20) {
                        // Title at the Top
                        Text("Tools")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        // Centered Image Carousel with Navigation
                        VStack {
                            TabView(selection: $currentImageIndex) {
                                ForEach(0..<images.count, id: \.self) { index in
                                    if index == 0 {
                                        // First image with NavigationLink
                                        NavigationLink(destination: MoodCheckView()) {
                                            Image(images[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 300, height: 200)
                                                .cornerRadius(15)
                                                .clipped()
                                        }
                                        .tag(index) // Tag the first image
                                    } else if index == 1 {
                                        // First image with NavigationLink
                                        NavigationLink(destination: ToDoView()) {
                                            Image(images[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 300, height: 200)
                                                .cornerRadius(15)
                                                .clipped()
                                        }
                                        .tag(index)
                                    }
                                }
                            }
                            .frame(height: 200)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                            .animation(.easeInOut, value: currentImageIndex)
                            
                            // Pagination Dots
                            HStack(spacing: 8) {
                                ForEach(0..<images.count, id: \.self) { index in
                                    Circle()
                                        .fill(index == currentImageIndex ? Color.purple : Color.gray.opacity(0.5))
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .padding(.top, 10)
                        }
                        
                        // Tools Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Tools")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                                ForEach(tools, id: \.0) { tool in
                                    VStack {
                                        Image(systemName: tool.1)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.purple)
                                        
                                        Text(tool.0)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 5)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
        }
    }
}


struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}
