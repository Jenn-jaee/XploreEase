import SwiftUI

struct RecreationView: View {
    @State private var showMenu = false
    @State private var selectedOption: RecreationOption? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Recreation Activities")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    if let option = selectedOption {
                        RecreationOptionDetailView(option: option)
                    } else {
                        Text("Please select a recreation activity from the menu")
                            .padding()
                    }
                }
                .blur(radius: showMenu ? 10 : 0)
                
                if showMenu {
                    RecreationSlidingMenuView(showMenu: $showMenu, selectedOption: $selectedOption)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .transition(.move(edge: .top))
                }
            }
            .gesture(DragGesture().onEnded { value in
                if value.translation.height > 100 {
                    withAnimation {
                        showMenu = true
                    }
                }
            })
            .onTapGesture {
                if showMenu {
                    withAnimation {
                        showMenu = false
                    }
                }
            }
        }
    }
}

enum RecreationOption: String, CaseIterable {
    case parks = "Parks"
    case museums = "Museums"
    case theaters = "Theaters"
    case concerts = "Concerts"
    case sports = "Sports"
    case zoos = "Zoos"
    case aquariums = "Aquariums"
    case beaches = "Beaches"
    case hiking = "Hiking"
    case biking = "Biking"
    // Add more options here
}

struct RecreationSlidingMenuView: View {
    @Binding var showMenu: Bool
    @Binding var selectedOption: RecreationOption?
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(RecreationOption.allCases, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    withAnimation {
                        showMenu = false
                    }
                }) {
                    Text(option.rawValue)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.vertical, 5)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.8))
        .cornerRadius(10)
        .padding(.top, 50)
    }
}

struct RecreationOptionDetailView: View {
    var option: RecreationOption
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(option.rawValue)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<10) { index in
                        HStack(spacing: 20) {
                            NavigationLink(destination: RecreationPaymentView(
                                recreationImage: "Recreation", 
                                recreationName: "Recreation \(index*1 + 1)", 
                                recreationDetails: "Details about recreation \(index*1 + 1)", 
                                recreationReview: "4.5 stars")) {
                                    RecreationListingBoxView(imageName: "Recreation", placeName: "Recreation \(index*1 + 1)", reviewRating: "4.5")
                                }
                            NavigationLink(destination: RecreationPaymentView(
                                recreationImage: "Recreation", 
                                recreationName: "Recreation \(index*2 + 2)", 
                                recreationDetails: "Details about recreation \(index*2 + 2)", 
                                recreationReview: "4.0 stars")) {
                                    RecreationListingBoxView(imageName: "Recreation", placeName: "Recreation \(index*2 + 2)", reviewRating: "4.0")
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct RecreationListingBoxView: View {
    var imageName: String
    var placeName: String
    var reviewRating: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            
            HStack {
                Image(systemName: "heart")
                    .foregroundColor(.red)
                    .padding(.trailing, 5)
                
                Text(placeName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .padding(.trailing, 5)
                
                Spacer()
                
                Text(reviewRating)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.trailing, 5)
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .frame(width: 150)
    }
}

struct RecreationPaymentView: View {
    var recreationImage: String
    var recreationName: String
    var recreationDetails: String
    var recreationReview: String
    
    @State private var paymentMethod = "Credit Card"
    @State private var cardNumber = ""
    @State private var expirationDate = ""
    @State private var cvv = ""
    @State private var showSuccessMessage = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Image(recreationImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.bottom)
                
                Text(recreationName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text(recreationDetails)
                    .font(.body)
                    .padding(.bottom, 5)
                
                Text("Review: \(recreationReview)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                
                Text("Payment Method")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Picker("Payment Method", selection: $paymentMethod) {
                    Text("Credit Card").tag("Credit Card")
                    Text("PayPal").tag("PayPal")
                    Text("Apple Pay").tag("Apple Pay")
                    // Add more payment methods if needed
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 20)
                
                Group {
                    TextField("Card Number", text: $cardNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                    
                    TextField("Expiration Date (MM/YY)", text: $expirationDate)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                    
                    TextField("CVV", text: $cvv)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                }
                
                Button(action: {
                    withAnimation {
                        showSuccessMessage = true
                    }
                }) {
                    Text("Pay")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.black) // Set background color to black
            .foregroundColor(.white) // Ensure text is white for readability
            .edgesIgnoringSafeArea(.all)
            
            if showSuccessMessage {
                SuccessMessageView(showSuccessMessage: $showSuccessMessage)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct SuccessMessageView: View {
    @Binding var showSuccessMessage: Bool
    
    var body: some View {
        VStack {
            Text("Payment Successful")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            
            Button(action: {
                withAnimation {
                    showSuccessMessage = false
                }
            }) {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .padding()
    }
}

struct RecreationView_Previews: PreviewProvider {
    static var previews: some View {
        RecreationView()
    }
}

struct RecreationPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        RecreationPaymentView(recreationImage: "exampleImage", recreationName: "Example Recreation", recreationDetails: "Details about the recreation go here.", recreationReview: "4.5 stars")
    }
}
