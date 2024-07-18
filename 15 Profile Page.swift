import SwiftUI
struct ProfileView: View {
    @State private var showSetup = false
    @State private var showSettings = false
    @State private var showLogoutConfirmation = false
    @State private var showLogoutSuccess = false
    @State private var starCount = 0
    
    @State private var yourName = "John Doe"
    @State private var bio = "A short bio about yourself."
    @State private var dateOfBirth = "4th July 2003"
    @State private var location = "San Francisco, CA"
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.black]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Text(yourName)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                Text(bio)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Date of birth:")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Location:")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Text(location)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(10)
                .padding()
                
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                showSetup.toggle()
                            }
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .padding(.bottom, 10)
                        
                        Button(action: {
                            withAnimation {
                                showSettings.toggle()
                            }
                        }) {
                            Image(systemName: "gearshape")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .padding(.bottom, 10)
                        
                        
                        Text("Stars: \(starCount)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    }
                }
            }
            
            if showSetup {
                ProfileSetupView(isPresented: $showSetup, yourName: $yourName, bio: $bio, dateOfBirth: $dateOfBirth,  location: $location)
                    .transition(.move(edge: .leading))
            }
            
            if showSettings {
                SettingsView(isPresented: $showSettings)
                    .transition(.move(edge: .leading))
            }

        }
        .navigationTitle("Profile")
        .onAppear {
            // Simulate fetching star count from a server or local storage
            fetchStarCount()
        }
    }
    
    private func fetchStarCount() {
        // Simulate fetching star count from a server or local storage
        // Replace this with your actual logic to fetch star count
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            starCount = 150 // Example star count
        }
    }
}

struct ProfileSetupView: View {
    @Binding var isPresented: Bool
    @Binding var yourName: String
    @Binding var bio: String
    @Binding var dateOfBirth: String
    @Binding var location: String
    
    var body: some View {
        VStack {
            Text("Profile Setup")
                .font(.largeTitle)
                .padding(.top, 50)
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .padding()
            
            TextField("Your Name", text: $yourName)
                .font(.title)
                .foregroundColor(.blue)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            TextField("Bio", text: $bio)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            TextField("Date of birth", text: $dateOfBirth)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            
            TextField("Location", text: $location)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Button(action: {
                withAnimation {
                    isPresented = false
                }
            }) {
                Text("Save Profile")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(.horizontal, 40)
        .padding(.vertical, 50)
    }
}


struct SettingsView: View {
        @Binding var isPresented: Bool
        
        // Settings state variables
        @State private var selectedLanguage = "English"
        @State private var tripUpdates = true
        @State private var dealsAndOffers = true
        @State private var locationAlerts = false
        @State private var travelTips = true
        @State private var userEmail = "example@example.com"
        @State private var userPhoneNumber = ""
        @State private var emergencyContacts: [String] = []
        @State private var isTwoFactorEnabled = false // Added for 2FA setup
        @State private var privacyPolicyAccepted = false // Track privacy policy acceptance
        
        let languages = ["English", "Spanish", "French", "German", "Chinese", "Japanese", "Korean", "Russian", "Portuguese", "Italian", "Arabic", "Hindi"]
        
        var body: some View {
                Form {
                        Section(header: Text("General")) {
                                NavigationLink(destination: LanguageSettingsView(selectedLanguage: $selectedLanguage, languages: languages)) {
                                        HStack {
                                                Text("Language")
                                                Spacer()
                                                Text(selectedLanguage)
                                                    .foregroundColor(.gray)
                                            }
                                    }
                                NavigationLink(destination: NotificationSettingsView(tripUpdates: $tripUpdates, dealsAndOffers: $dealsAndOffers, locationAlerts: $locationAlerts, travelTips: $travelTips)) {
                                        Text("Notification Settings")
                                    }
                                Toggle(isOn: .constant(true)) {
                                        Text("Location Services")
                                    }
                            }
                        
                        Section(header: Text("Account and Security")) {
                                NavigationLink(destination: EmailSettingsView(userEmail: $userEmail)) {
                                        VStack(alignment: .leading) {
                                                Text("Email")
                                                Text(userEmail)
                                                    .foregroundColor(.gray)
                                                    .font(.caption)
                                            }
                                    }
                                NavigationLink(destination: MobileNumberSettingsView(userPhoneNumber: $userPhoneNumber, emergencyContacts: $emergencyContacts)) {
                                        VStack(alignment: .leading) {
                                                Text("Mobile Number")
                                                Text(userPhoneNumber.isEmpty ? "Not set" : userPhoneNumber)
                                                    .foregroundColor(.gray)
                                                    .font(.caption)
                                            }
                                    }
                                NavigationLink(destination: SecuritySettingsView(isTwoFactorEnabled: $isTwoFactorEnabled)) {
                                        Text("Security")
                                    }
                                Button(action: {
                                        // Action for delete account
                                    }) {
                                            Text("Delete Account")
                                                .foregroundColor(.red)
                                        }
                            }
                        
                        Section(header: Text("Emergency Contacts")) {
                                ForEach(emergencyContacts, id: \.self) { contact in
                                        Text(contact)
                                    }
                                Button(action: {
                                        // Action to add emergency contact
                                        emergencyContacts.append("New Emergency Contact")
                                    }) {
                                            Text("Add Emergency Contact")
                                        }
                            }
                        
                        Section(header: Text("Other")) {
                                NavigationLink(destination: AboutAppView()) {
                                        Text("About XploreEase App")
                                    }
                                NavigationLink(destination: PrivacyPolicyView(privacyPolicyAccepted: $privacyPolicyAccepted)) {
                                        Text("Privacy Policy")
                                    }
                                NavigationLink(destination: TermsConditionsView()) {
                                        Text("Terms and Conditions")
                                    }
                                NavigationLink(destination: RateAppView()) {
                                        Text("Rate XploreEase App")
                                    }
                            }
                    }
                .navigationBarTitle("Settings", displayMode: .inline)
            }
}

struct EmailSettingsView: View {
        @Binding var userEmail: String
        
        var body: some View {
                VStack(spacing: 20) {
                        Text("Registered Email")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text(userEmail)
                            .font(.body)
                        
                        TextField("New Email", text: $userEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                                // Action to update email logic
                                // For example:
                                // updateUserEmail(newEmail: userEmail)
                            }) {
                                    Text("Update Email")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                        .padding(.top, 20)
                    }
                .padding()
                .navigationTitle("Email Settings")
            }
}

struct MobileNumberSettingsView: View {
        @Binding var userPhoneNumber: String
        @Binding var emergencyContacts: [String]
        
        var body: some View {
                VStack(spacing: 20) {
                        Text("Mobile Number")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        TextField("Phone Number", text: $userPhoneNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Section(header: Text("Emergency Contacts")) {
                                ForEach(emergencyContacts, id: \.self) { contact in
                                        Text(contact)
                                    }
                                Button(action: {
                                        // Action to add emergency contact
                                        emergencyContacts.append("New Emergency Contact")
                                    }) {
                                            Text("Add Emergency Contact")
                                        }
                            }
                    }
                .padding()
                .navigationTitle("Mobile Number Settings")
            }
}

struct SecuritySettingsView: View {
        @Binding var isTwoFactorEnabled: Bool // Added for 2FA setup
        @State private var selected2FAMethod = 0 // 0: Text Message, 1: Email, 2: Other (e.g., Face ID)
        
        var body: some View {
                Form {
                        Section(header: Text("Security")) {
                                Toggle(isOn: $isTwoFactorEnabled) {
                                        Text("Two-Factor Authentication")
                                    }
                                
                                if isTwoFactorEnabled {
                                        Picker(selection: $selected2FAMethod, label: Text("Choose 2FA Method")) {
                                                Text("Text Message").tag(0)
                                                Text("Email").tag(1)
                                                Text("Other").tag(2)
                                            }
                                        .pickerStyle(SegmentedPickerStyle())
                                        .padding(.vertical)
                                    }
                                
                                NavigationLink(destination: SecurityUpdatesView()) {
                                        Text("Security Updates")
                                    }
                            }
                    }
                .navigationBarTitle("Security Settings", displayMode: .inline)
            }
}

struct SecurityUpdatesView: View {
        var body: some View {
                VStack(alignment: .leading) {
                        Text("Security Tips for New Town")
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        Text("Always be cautious of your surroundings when visiting new places. Avoid sharing personal information with strangers.")
                            .font(.body)
                        
                        Spacer()
                    }
                .padding()
                .navigationTitle("Security Updates")
            }
}

struct AboutAppView: View {
        var body: some View {
                Text("About XploreEase App View")
                    .navigationTitle("About XploreEase App")
            }
}

struct PrivacyPolicyView: View {
        @Binding var privacyPolicyAccepted: Bool
        
        var body: some View {
                ScrollView {
                        VStack(spacing: 20) {
                                Text("Privacy Policy")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                
                                Text("Welcome to XploreEase App! Your privacy is important to us. This Privacy Policy explains how we collect, use, share, and protect your personal information when you use our services.")
                                
                                Toggle(isOn: $privacyPolicyAccepted) {
                                        Text("I accept the Privacy Policy")
                                    }
                                .padding(.top, 20)
                            }
                        .padding()
                    }
                .navigationTitle("Privacy Policy")
            }
}

struct TermsConditionsView: View {
        var body: some View {
                Text("Terms and Conditions View")
                    .navigationTitle("Terms and Conditions")
            }
}

struct RateAppView: View {
        var body: some View {
                Text("Rate XploreEase App View")
                    .navigationTitle("Rate XploreEase App")
            }
}

struct LanguageSettingsView: View {
        @Binding var selectedLanguage: String
        let languages: [String]
        
        var body: some View {
                List {
                        ForEach(languages, id: \.self) { language in
                                HStack {
                                        Text(language)
                                        Spacer()
                                        if language == selectedLanguage {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.blue)
                                            }
                                    }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                        selectedLanguage = language
                                    }
                            }
                    }
                .navigationTitle("Language Settings")
            }
}

struct NotificationSettingsView: View {
        @Binding var tripUpdates: Bool
        @Binding var dealsAndOffers: Bool
        @Binding var locationAlerts: Bool
        @Binding var travelTips: Bool
        
        var body: some View {
                Form {
                        Section(header: Text("Notification Settings")) {
                                Toggle(isOn: $tripUpdates) {
                                        Text("Trip Updates")
                                    }
                                Toggle(isOn: $dealsAndOffers) {
                                        Text("Deals and Offers")
                                    }
                                Toggle(isOn: $locationAlerts) {
                                        Text("Location Alerts")
                                    }
                                Toggle(isOn: $travelTips) {
                                        Text("Travel Tips")
                                    }
                            }
                    }
                .navigationBarTitle("Notification Settings", displayMode: .inline)
            }
}

struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
                ProfileView()
            }
}
