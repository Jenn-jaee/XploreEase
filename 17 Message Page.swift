import SwiftUI

// Example data for chat messages
struct ChatMessage: Identifiable {
        var id: Int
        var message: String
        var senderId: Int
        var timestamp: Date
}

// Example data for users
struct User: Identifiable {
        var id: Int
        var name: String
        var profileImage: String // Ensure this matches your image asset names or URLs
}

// Example data for chats
struct Chat: Identifiable {
        var id: Int
        var users: [User] // Array of users participating in the chat
        var messages: [ChatMessage]
}

// Chat row view
struct ChatRow: View {
        var chat: Chat
        
        var body: some View {
                HStack(spacing: 12) {
                        Image(chat.users.first?.profileImage ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                                Text(chat.users.count > 1 ? "Group Chat" : chat.users.first?.name ?? "")
                                    .font(.headline)
                                
                                Text(chat.messages.last?.message ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        
                        Spacer()
                    }
                .padding(.vertical, 8)
            }
}

// Chat detail view
struct ChatDetailView: View {
        @Binding var chat: Chat
        var sendMessage: (String) -> Void
        @State private var newMessageText: String = ""
        
        var body: some View {
                VStack {
                        ScrollView {
                                LazyVStack(alignment: .leading, spacing: 12) {
                                        ForEach(chat.messages) { message in
                                                MessageView(message: message)
                                            }
                                    }
                            }
                        
                        // Message input field and send button
                        MessageInputView(newMessageText: $newMessageText, sendMessage: {
                                sendMessage(newMessageText)
                                newMessageText = ""
                            })
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                .navigationBarTitle(chat.users.count > 1 ? "Group Chat" : "Chat with \(chat.users.first?.name ?? "")", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                        // Add action for managing group (e.g., add/remove participants)
                    }) {
                            Image(systemName: "person.2.fill")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        })
            }
}

// Message view for displaying individual messages
struct MessageView: View {
        var message: ChatMessage
        
        var body: some View {
                HStack {
                        if message.senderId == 1 {
                                Spacer()
                            }
                        
                        Text(message.message)
                            .padding(12)
                            .foregroundColor(.white)
                            .background(message.senderId == 1 ? Color.blue : Color.gray)
                            .cornerRadius(16)
                        
                        if message.senderId == 2 {
                                Spacer()
                            }
                    }
                .padding(.horizontal, 12)
            }
}

// Message input view
struct MessageInputView: View {
        @Binding var newMessageText: String
        var sendMessage: () -> Void
        
        var body: some View {
                HStack {
                        TextField("Type a message", text: $newMessageText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        Button(action: sendMessage) {
                                Image(systemName: "paperplane.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                            }
                        .padding(.trailing)
                    }
            }
}

// Chatbot view for assistance
struct ChatbotView: View {
        @State private var chatbotMessages: [ChatMessage] = [
                ChatMessage(id: 1, message: "Hi! How can I assist you with your travels?", senderId: 2, timestamp: Date())
            ]
        @State private var newMessageText: String = ""
        
        var body: some View {
                VStack {
                        ScrollView {
                                LazyVStack(alignment: .leading, spacing: 12) {
                                        ForEach(chatbotMessages) { message in
                                                MessageView(message: message)
                                            }
                                    }
                            }
                        
                        // Message input field and send button
                        MessageInputView(newMessageText: $newMessageText, sendMessage: sendMessage)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                .navigationBarTitle("Chatbot Assistance", displayMode: .inline)
            }
        
        private func sendMessage() {
                guard !newMessageText.isEmpty else { return }
                
                let newMessage = ChatMessage(id: chatbotMessages.count + 1, message: newMessageText, senderId: 1, timestamp: Date())
                chatbotMessages.append(newMessage)
                
                // Add chatbot response
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        let response = getChatbotResponse(to: newMessageText)
                        let responseMessage = ChatMessage(id: self.chatbotMessages.count + 1, message: response, senderId: 2, timestamp: Date())
                        self.chatbotMessages.append(responseMessage)
                    }
                
                newMessageText = ""
            }
        
        private func getChatbotResponse(to message: String) -> String {
                let lowercasedMessage = message.lowercased()
                
                if lowercasedMessage.contains("transport") {
                        return "You can use local buses, taxis, or rideshare services like Uber and Lyft to get around. Do you need specific directions or information?"
                    } else if lowercasedMessage.contains("accommodation") || lowercasedMessage.contains("hotel") {
                            return "There are many great places to stay. Do you need recommendations for hotels, hostels, or vacation rentals?"
                        } else if lowercasedMessage.contains("food") || lowercasedMessage.contains("restaurant") || lowercasedMessage.contains("dining") {
                                return "You can find a variety of dining options. Are you looking for local cuisine, vegetarian options, or something specific?"
                            } else if lowercasedMessage.contains("attractions") || lowercasedMessage.contains("sightseeing") || lowercasedMessage.contains("things to do") {
                                    return "There are many attractions to visit. Do you need information about museums, parks, or popular tourist spots?"
                                } else if lowercasedMessage.contains("emergency") || lowercasedMessage.contains("help") {
                                        return "In case of an emergency, you can call 911 for immediate assistance. For non-emergency issues, do you need the contact for local authorities or medical facilities?"
                                    } else {
                                            return "I'm here to help with any travel-related questions you have. How can I assist you further?"
                                        }
            }
}

// Messages view containing chat list
struct MessagesView: View {
        @State private var newMessageText: String = ""
        @State private var selectedChatId: Int? = nil
        @State private var chats: [Chat] = [
                Chat(id: 1, users: [User(id: 1, name: "John Dawn", profileImage: "profile1")], messages: []),
                Chat(id: 2, users: [User(id: 2, name: "Jane Smith", profileImage: "profile2")], messages: []),
                Chat(id: 3, users: [User(id: 3, name: "Michael Johnson", profileImage: "profile3")], messages:[]),
                Chat(id: 4, users: [User(id: 4, name: "Emily Davis", profileImage: "profile4")], messages:[]),
                Chat(id: 5, users: [User(id: 5, name: "David Brown", profileImage: "profile5")], messages: [])
            ]
        @State private var showChatbot = false
        @State private var showUserSelection = false
        @State private var selectedUsers: [User] = []
        
        // Example users data
        let users: [User] = [
                User(id: 1, name: "John Dawn", profileImage: "profile1"),
                User(id: 2, name: "Jane Smith", profileImage: "profile2"),
                User(id: 3, name: "Michael Johnson", profileImage: "profile3"),
                User(id: 4, name: "Emily Davis", profileImage: "profile4"),
                User(id: 5, name: "David Brown", profileImage: "profile5")
            ]
        
        var body: some View {
                NavigationView {
                        ZStack {
                                VStack {
                                        // Chat list view
                                        List {
                                                ForEach(chats) { chat in
                                                        NavigationLink(destination: ChatDetailView(chat: Binding(
                                                                get: { chat },
                                                                set: { updatedChat in
                                                                        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
                                                                                chats[index] = updatedChat
                                                                            }
                                                                    }), sendMessage: { messageText in
                                                                            sendMessage(chat: chat, messageText: messageText)
                                                                        })) {
                                                                                Group {
                                                                                        if chat.users.count > 1 {
                                                                                                VStack(alignment: .leading, spacing: 4) {
                                                                                                        Text("Group Chat")
                                                                                                            .font(.headline)
                                                                                                            .foregroundColor(.primary)
                                                                                                        Text("\(chat.users.count) participants")
                                                                                                            .font(.subheadline)
                                                                                                            .foregroundColor(.secondary)
                                                                                                    }
                                                                                            } else {
                                                                                                    ChatRow(chat: chat)
                                                                                                }
                                                                                    }
                                                                            }
                                                    }
                                            }
                                        .listStyle(PlainListStyle())
                                        .navigationBarTitle("Chats")
                                        .navigationBarItems(trailing: Button(action: {
                                                showUserSelection.toggle()
                                            }) {
                                                    Image(systemName: "person.crop.circle.badge.plus")
                                                        .imageScale(.large)
                                                        .foregroundColor(.blue)
                                                })
                                        
                                        // Chat detail view
                                        if let selectedChatId = selectedChatId, let currentChat = chats.first(where: { $0.id == selectedChatId }) {
                                                ChatDetailView(chat: Binding(
                                                        get: { currentChat },
                                                        set: { updatedChat in
                                                                if let index = chats.firstIndex(where: { $0.id == currentChat.id }) {
                                                                        chats[index] = updatedChat
                                                                    }
                                                            }), sendMessage: { messageText in
                                                                    sendMessage(chat: currentChat, messageText: messageText)
                                                                })
                                                .navigationBarTitle(currentChat.users.count > 1 ? "Group Chat" : "Chat with \(currentChat.users.first?.name ?? "")", displayMode: .inline)
                                            } else {
                                                    Text("Select a chat to start messaging")
                                                        .font(.title)
                                                        .foregroundColor(.gray)
                                                }
                                    }
                                
                                // Floating button for chatbot
                                VStack {
                                        Spacer()
                                        HStack {
                                                Spacer()
                                                Button(action: {
                                                        showChatbot.toggle()
                                                    }) {
                                                            Image(systemName: "questionmark.circle.fill")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 50, height: 50)
                                                                .foregroundColor(.blue)
                                                                .padding()
                                                                .background(Color.white)
                                                                .clipShape(Circle())
                                                                .shadow(radius: 2)
                                                        }
                                                .padding()
                                            }
                                    }
                            }
                        .sheet(isPresented: $showChatbot) {
                                ChatbotView()
                            }
                        
                        // User selection view
                        if showUserSelection {
                                VStack {
                                        Text("Select users to create a group chat")
                                            .font(.headline)
                                            .padding()
                                        
                                        List {
                                                ForEach(users) { user in
                                                        Button(action: {
                                                                if selectedUsers.contains(where: { $0.id == user.id }) {
                                                                        selectedUsers.removeAll(where: { $0.id == user.id })
                                                                    } else {
                                                                            selectedUsers.append(user)
                                                                        }
                                                            }) {
                                                                    HStack {
                                                                            Text(user.name)
                                                                            Spacer()
                                                                            if selectedUsers.contains(where: { $0.id == user.id }) {
                                                                                    Image(systemName: "checkmark.circle.fill")
                                                                                        .foregroundColor(.blue)
                                                                                }
                                                                        }
                                                                }
                                                    }
                                            }
                                        .listStyle(PlainListStyle())
                                        .padding()
                                        
                                        Button(action: {
                                                createGroupChat()
                                                showUserSelection = false
                                            }) {
                                                    Text("Create Group Chat")
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .frame(maxWidth: .infinity)
                                                        .background(Color.blue)
                                                        .cornerRadius(12)
                                                        .padding()
                                                }
                                    }
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(radius: 4)
                                .padding()
                            }
                    }
            }
        
        private func sendMessage(chat: Chat, messageText: String) {
                guard !messageText.isEmpty else { return }
                
                if let index = chats.firstIndex(where: { $0.id == chat.id }) {
                        let newMessage = ChatMessage(id: chats[index].messages.count + 1, message: messageText, senderId: 1, timestamp: Date())
                        chats[index].messages.append(newMessage)
                    }
            }
        
        private func createGroupChat() {
                let newChatId = chats.count + 1
                let newChat = Chat(id: newChatId, users: selectedUsers, messages: [])
                chats.append(newChat)
                
                // Select the newly created chat
                selectedChatId = newChatId
            }
}

// Preview
struct MessagesView_Previews: PreviewProvider {
        static var previews: some View {
                MessagesView()
            }
}
