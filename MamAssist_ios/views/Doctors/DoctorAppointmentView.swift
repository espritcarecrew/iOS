import SwiftUI

struct DoctorAppointmentView: View {
    @State private var selectedDate = 0 // Selected date index
    let dates = ["Mon 21", "Mon 22", "Mon 23", "Mon 24", "Mon 25"] // Sample dates

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Doctor Header Section
                VStack(spacing: 10) {
                    Image("doctor1") // Replace with your asset name
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text("Dr. Devy Shety")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Heart Surgeon")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .cornerRadius(20)
                .padding(.horizontal)

                // Doctor Details Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Doctor's Details")
                        .font(.headline)
                        .foregroundColor(.purple)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Experience: 15 years")
                        Text("Specialization: Cardiothoracic Surgery")
                        Text("Contact: +1 234 567 890")
                        Text("Location: New York City, USA")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                    )
                }
                .padding(.horizontal)

                // Date Selection Section
                VStack(alignment: .leading, spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<dates.count, id: \.self) { index in
                                Button(action: {
                                    selectedDate = index
                                }) {
                                    Text(dates[index])
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(selectedDate == index ? Color.purple : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedDate == index ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                // Time Slots Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Morning")
                        .font(.headline)
                        .foregroundColor(.purple)

                    HStack(spacing: 10) {
                        ForEach(["08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM"], id: \.self) { time in
                            TimeSlotButton(time: time)
                        }
                    }

                    Text("Evening")
                        .font(.headline)
                        .foregroundColor(.purple)

                    HStack(spacing: 10) {
                        ForEach(["05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM"], id: \.self) { time in
                            TimeSlotButton(time: time)
                        }
                    }
                }
                .padding(.horizontal)

                // Book Appointment Button
                Button(action: {
                    // Action for booking appointment
                }) {
                    Text("BOOK AN APPOINTMENT")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 20) // Add padding for safe area
        }
        .background(Color("PeachBackground").edgesIgnoringSafeArea(.all))
    }
}

// Reusable Time Slot Button
struct TimeSlotButton: View {
    let time: String
    @State private var isSelected = false

    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            Text(time)
                .padding()
                .frame(minWidth: 80)
                .background(isSelected ? Color.purple : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(10)
        }
    }
}

struct DoctorAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorAppointmentView()
    }
}
