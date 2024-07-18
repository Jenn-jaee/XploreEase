import SwiftUI

struct OnboardingView4: View {
    var body: some View {
        ZStack {
            Image("Onboarding 4") // Replace with your image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                Text("Start Your Adventure")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.top, 20)
                Text("Embark on a journey filled with amazing experiences and memories.")
                    .font(.subheadline)
                    .bold() // Making the text bold
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                NavigationLink(destination: LoginView()) {
                    Text("Get Started")
                        .font(.headline)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.2))
                )
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct OnboardingView4_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView4()
    }
}

