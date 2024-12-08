import SwiftUI

struct DoctorFinderView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Good Morning and stay healthy")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text("Find your desired\nDoctor Right Now!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineSpacing(5)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "bell")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.8)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(20)
                .padding(.horizontal)

                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search Doctor or Symptom", text: .constant(""))
                        .foregroundColor(.gray)
                        .padding(.vertical, 10)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(25)
                .padding(.horizontal)

                // Categories Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Categories")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    HStack(spacing: 15) {
                        CategoryButton(title: "Gynécologie")
                        CategoryButton(title: "Pédiatrie")
                        CategoryButton(title: "Endocrinologie")
                        CategoryButton(title: "Nutritionniste")
                    }
                }
                .padding(.horizontal)

                // Recommended Doctors Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Recommended Doctors")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        Text("See All")
                            .font(.subheadline)
                            .foregroundColor(.purple)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            DoctorCard(
                                name: "Dr. Amelia Daniel",
                                specialty: "Dermatologist",
                                imageName: "doctor1"
                            )
                            DoctorCard(
                                name: "Dr. Erik Wagner",
                                specialty: "Urology",
                                imageName: "doctor2"
                            )
                            DoctorCard(
                                name: "Dr. Lisa Johnson",
                                specialty: "Cardiology",
                                imageName: "doctor3"
                            )
                        }
                        .padding(.horizontal)
                    }
                }

                // Consultation Schedule Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Consultation Schedule")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        Text("See All")
                            .font(.subheadline)
                            .foregroundColor(.purple)
                    }
                    
                    VStack(spacing: 15) {
                        ConsultationScheduleCard(
                            name: "Dr. Jackson Moraes",
                            specialty: "Dermatology & Leprosy",
                            imageName: "doctor1"
                        )
                        ConsultationScheduleCard(
                            name: "Dr. Amelia Daniel",
                            specialty: "Dermatologist",
                            imageName: "doctor2"
                        )
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
    }
}

// Reusable Category Button
struct CategoryButton: View {
    let title: String

    var body: some View {
        VStack {
            Circle()
                .fill(Color.purple.opacity(0.2)) // Changed to purple
                .frame(width: 60, height: 60)
                .overlay(
                    Text(String(title.prefix(1)))
                        .font(.headline)
                        .foregroundColor(.purple) // Changed to purple
                )
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}

// Reusable Doctor Card
struct DoctorCard: View {
    let name: String
    let specialty: String
    let imageName: String

    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "heart")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.red)
                                .clipShape(Circle())
                                .padding(8)
                            Spacer()
                        }
                    }
                )
            
            Text(name)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text(specialty)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 140)
    }
}

// Reusable Consultation Schedule Card
struct ConsultationScheduleCard: View {
    let name: String
    let specialty: String
    let imageName: String

    var body: some View {
        HStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(specialty)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
        )
    }
}

struct DoctorFinderView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorFinderView()
    }
}
