import SwiftUI

struct DiningView: View {
    @State private var showMenu = false
    @State private var selectedOption: DiningOption? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Dining Options")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    if let option = selectedOption {
                        DiningOptionDetailView(option: option)
                    } else {
                        Text("Please select a dining option from the menu")
                            .padding()
                    }
                }
                .blur(radius: showMenu ? 10 : 0)
                
                if showMenu {
                    DiningSlidingMenuView(showMenu: $showMenu, selectedOption: $selectedOption)
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

enum DiningOption: String, CaseIterable {
    case restaurants = "Restaurants"
    case cafes = "Cafes"
    case fastFood = "Fast Food"
    case diners = "Diners"
    case foodTrucks = "Food Trucks"
    case bakeries = "Bakeries"
    case buffets = "Buffets"
    case pubs = "Pubs"
    case bistros = "Bistros"
    case foodCourt = "Food Court"
    // Add more options here
}

struct DiningSlidingMenuView: View {
    @Binding var showMenu: Bool
    @Binding var selectedOption: DiningOption?
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(DiningOption.allCases, id: \.self) { option in
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

struct DiningOptionDetailView: View {
    var option: DiningOption
    
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
                            NavigationLink(destination: DiningPaymentView(
                                diningImage: "Dining", 
                                diningName: "Dining \(index*1 + 1)", 
                                diningDetails: "Details about dining \(index*1 + 1)", 
                                diningReview: "4.5 stars")) {
                                    DiningListingBoxView(imageName: "Dining", placeName: "Dining \(index*1 + 1)", reviewRating: "4.5")
                                }
                            NavigationLink(destination: DiningPaymentView(
                                diningImage: "Dining", 
                                diningName: "Dining \(index*2 + 2)", 
                                diningDetails: "Details about dining \(index*2 + 2)", 
                                diningReview: "4.0 stars")) {
                                    DiningListingBoxView(imageName: "Dining", placeName: "Dining \(index*2 + 2)", reviewRating: "4.0")
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct DiningListingBoxView: View {
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

struct DiningPaymentView: View {
    var diningImage: String
    var diningName: String
    var diningDetails: String
    var diningReview: String
    
    @State private var paymentMethod = "Credit Card"
    @State private var cardNumber = ""
    @State private var expirationDate = ""
    @State private var cvv = ""
    @State private var showSuccessMessage = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Image(diningImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.bottom)
                
                Text(diningName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text(diningDetails)
                    .font(.body)
                    .padding(.bottom, 5)
                
                Text("Review: \(diningReview)")
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

struct SuccessMessageView2: View {
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

struct DiningView_Previews: PreviewProvider {
    static var previews: some View {
        DiningView()
    }
}

struct DiningPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        DiningPaymentView(diningImage: "exampleImage", diningName: "Example Dining", diningDetails: "Details about the dining go here.", diningReview: "4.5 stars")
    }
}
