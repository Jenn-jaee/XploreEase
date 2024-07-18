import SwiftUI

struct OnboardingView1: View {
    var body: some View {
        ZStack {
            Image("Onboarding 1") // Replace with your image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Discover New Places")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.top, 20)
                    
                    Text("Find the best and affordable places to stay, eat, and explore with ease.")
                        .font(.subheadline)
                        .bold() // Making the text bold
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 40)
                        .padding(.bottom, 40)
                    
                    NavigationLink(destination: OnboardingView2()) {
                        Text("Next")
                            .font(.headline)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.2))
                )
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct OnboardingView1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView1()
    }
}
