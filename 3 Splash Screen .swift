import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var logoScale: CGFloat = 1.5 // Start with a larger scale
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Background color
            
            Image("XploreEase") // Replace with your image
                .resizable()
                .scaledToFit()
                .scaleEffect(logoScale) // Apply the scale effect
                .onAppear {
                    withAnimation(.easeInOut(duration: 2)) { // Add animation
                        logoScale = 1.0 // Reduce the scale to create the zoom-out effect
                    }
                }
            
            if isActive {
                OnboardingView1()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
