import SwiftUI

struct OnboardingView2: View {
    var body: some View {
        ZStack {
            Image("Onboarding 2") // Replace with your image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                Text("Plan Your Trip")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                Text("Create personalized itineraries and make the most of your travels.")
                    .font(.subheadline)
                    .bold() // Making the text bold
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                NavigationLink(destination: OnboardingView3()) {
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

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView2()
    }
}
