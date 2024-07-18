import SwiftUI

struct CreateAccountView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var age = ""
    @State private var countryCode = ""
    @State private var acceptTerms = false
    @State private var accountCreated = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Background color
            
            VStack(alignment: .leading, spacing: 20) {
                if accountCreated {
                    AccountCreatedView()
                } else {
                    Text("Create Account")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding([.top, .leading], 20)
                    
                    Text("Get the best out of XploreEase by creating an account")
                        .foregroundColor(.white)
                        .padding([.leading, .trailing], 20)
                    
                    Group {
                        Text("First Name")
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 20)
                        TextField("", text: $firstName)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        Text("Last Name")
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 20)
                        TextField("", text: $lastName)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        Text("Phone")
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 20)
                        HStack {
                            TextField("Code", text: $countryCode)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            TextField("Number", text: $phone)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        
                        Text("Age")
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 20)
                        TextField("", text: $age)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        Text("Email")
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 20)
                        TextField("", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        Text("Password")
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 20)
                        SecureField("", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        Button(action: {
                            acceptTerms.toggle()
                        }) {
                            Image(systemName: acceptTerms ? "checkmark.square" : "square")
                                .foregroundColor(.white)
                        }
                        Text("I accept the terms and conditions")
                            .foregroundColor(.white)
                        NavigationLink(destination: TermsAndConditionsView()) {
                            Text("terms and conditions")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Simulate create account action for demo
                        self.accountCreated.toggle()
                    }) {
                        Text("Create Account")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.white)
                        NavigationLink(destination: LoginView()) {
                            Text("Go back")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct AccountCreatedView: View {
    var body: some View {
        VStack {
            // Placeholder for app logo
            Image("XploreEase") // Replace with your image
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
                .padding(.top, 40)
            
            Text("Successfully Created")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            Text("You can now Xplore with ease!")
                .foregroundColor(.white)
                .padding()
            
            NavigationLink(destination: LoginView()) {
                Text("Let's Explore")
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

struct TermsAndConditionsView: View {
    var body: some View {
        Text("Terms and Conditions content goes here.")
            .foregroundColor(.white)
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
