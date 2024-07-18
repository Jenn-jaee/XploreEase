import SwiftUI

struct OnboardingView3: View {
    var body: some View {
        ZStack {
            Image("Onboarding 3") // Replace with your image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                Text("Connect with Locals")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.top, 20)
                Text("Get insider tips and advice from locals to make your trip unforgettable.")
                    .font(.subheadline)
                    .bold() // Making the text bold
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                NavigationLink(destination: OnboardingView4()) {
                    Text("Next")
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

struct OnboardingView3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView3()
    }
}
