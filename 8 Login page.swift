import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false // Track login state
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) // Background color
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text("Welcome to XploreEase")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 40)
                    
                    Text("Please choose your login option below")
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Password?")
                                .foregroundColor(.blue)
                                .padding(.trailing, 16)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Simulate login success
                        isLoggedIn = true
                    }) {
                        Text("Login")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .fullScreenCover(isPresented: $isLoggedIn) {
                        HomeView()
                    }
                    
                    Spacer()
                    
                    HStack {
                        line
                        Text("or login with")
                            .foregroundColor(.gray)
                        line
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    Spacer()
                    
                    HStack {
                        socialLoginButton(imageName: "facebook", color: Color.blue)
                        socialLoginButton(imageName: "google", color: Color.red)
                        socialLoginButton(imageName: "apple", color: Color.black)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack {
                        Text("Don't have an account on XploreEase?")
                        NavigationLink(destination: CreateAccountView()) {
                            Text("Create account")
                                .foregroundColor(.blue)
                        }
                        .navigationBarBackButtonHidden(true) // Hide back button for CreateAccountView
                        .navigationBarHidden(true) // Hide navigation bar when navigating to CreateAccountView
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true) // Hide navigation bar for LoginView
        }
    }
    
    private var line: some View {
        VStack {
            Divider()
                .background(Color.gray)
        }
        .padding(.horizontal)
    }
    
    private func socialLoginButton(imageName: String, color: Color) -> some View {
        Button(action: {
            // Handle social login action
        }) {
            HStack {
                Image(systemName: imageName)
                Text(imageName.capitalized)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(8)
        }
    }
}


struct ForgotPasswordView: View {
    @State private var emailOrPhone = ""
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Background color
            
            VStack(alignment: .leading) {
                Text("Forgot Password")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding([.top, .leading], 20)
                
                Text("Enter your email or phone, we will send the verification code to reset your password.")
                    .foregroundColor(.white)
                    .padding([.top, .leading, .trailing], 20)
                    .padding(.bottom, 20)
                Spacer()
                
                TextField("Email or Phone", text: $emailOrPhone)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .accentColor(.white)
                
                NavigationLink(destination: ResetWithPhoneNumberView()) {
                    Text("Reset with phone number")
                        .foregroundColor(.blue)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                }
                Spacer()
                Spacer()
                
                Button(action: {
                    // Handle request code action
                }) {
                    Text("Request Code")
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
            }
        }
    }
}

struct ResetWithPhoneNumberView: View {
    @State private var phoneNumber = ""
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Background color
            
            VStack(alignment: .leading) {
                Text("Reset with Phone Number")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding([.top, .leading], 20)
                
                Text("Enter your phone number, we will send the verification code to reset your password.")
                    .foregroundColor(.white)
                    .padding([.top, .leading, .trailing], 20)
                    .padding(.bottom, 20)
                Spacer()
                
                TextField("Phone Number", text: $phoneNumber)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .accentColor(.white)
                Spacer()
                Spacer()
                
                Button(action: {
                    // Handle request code action
                }) {
                    Text("Request Code")
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
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
