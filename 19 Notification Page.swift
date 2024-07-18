import SwiftUI

struct NotificationItem: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}

struct NotificationsView: View {
    
    // Sample notifications
    let notifications: [NotificationItem] = [
        NotificationItem(title: "New Message", description: "You have a new chat message."),
        NotificationItem(title: "Trip Update", description: "Your trip details have been updated."),
        NotificationItem(title: "Deal Offer", description: "New deals available for your destination."),
        NotificationItem(title: "Location Alert", description: "You've reached an interesting location."),
        NotificationItem(title: "Travel Tips", description: "Check out our latest travel tips."),
        NotificationItem(title: "Adventure Discovery", description: "Discover a hidden gem near your location."),
        NotificationItem(title: "Event Reminder", description: "Don't miss out on local events."),
        NotificationItem(title: "Weather Update", description: "Current weather conditions at your destination."),
        NotificationItem(title: "Deal Offer", description: "New deals available for your destination."),
        NotificationItem(title: "Travel Tips", description: "Check out our latest travel tips."),
        NotificationItem(title: "Event Reminder", description: "Don't miss out on local events."),
        NotificationItem(title: "New Message", description: "You have a new chat message."),
        NotificationItem(title: "Event Reminder", description: "Don't miss out on local events."),
        // Add more notifications as needed
    ]
    
    var body: some View {
        ZStack {
            Color.black
            NavigationView {
                
                List(notifications, id: \.id) { notification in
                    NavigationLink(destination: NotificationDetailView(notification: notification)) {
                        VStack(alignment: .leading) {
                            Text(notification.title)
                                .font(.headline)
                            Text(notification.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("Notifications")
            }
        }
        
    }
    
}

struct NotificationDetailView: View {
    var notification: NotificationItem
    
    // Random messages
    let randomMessages = [
        "You've won a surprise discount on your next booking!",
        "Explore local cuisine and culture in this area.",
        "Plan your next adventure with our travel guides.",
        "Discover scenic spots just a short drive away.",
        "Get insider tips on making the most of your trip.",
        // Add more random messages as needed
    ]
    
    // Function to get a random message
    func getRandomMessage() -> String {
        return randomMessages.randomElement() ?? "Discover something amazing today!"
    }
    
    var body: some View {
        ZStack{
            Color.black
            
            VStack {
                
                Text(notification.description)
                    .padding()
                
                Text(getRandomMessage()) // Display random message
                
                Spacer()
            }
            .navigationBarTitle(notification.title)
            .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)) // Background color for the detail view
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
