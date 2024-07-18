import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationView {
                    ZStack {
                        TabView {
                            // HousingView removed as per your request
                            TabItemView(imageName: "house.fill", text: "Home") {
                                // Navigate to Housing page
                            }
                            
                        
                            WishlistView()
                                .tabItem {
                                    Image(systemName: "heart.fill")
                                    Text("Wishlist")
                                }
                            MessagesView()
                                .tabItem {
                                    Image(systemName: "message.fill")
                                    Text("Message")
                                }
                            MapView()
                                .tabItem {
                                    Image(systemName: "map.fill")
                                    Text("Map")
                                }
                            NotificationsView()
                                .tabItem {
                                    Image(systemName: "bell.fill")
                                    Text("Notification")
                                }
                            
                            ProfileView()
                                .tabItem {
                                    Image(systemName: "person.fill")
                                    Text("Profile")
                                }
                        }
                        .navigationBarItems(
                            leading: NavigationLink(destination: MessagesView()) {
                                Image(systemName: "message.fill")
                                    .foregroundColor(.blue)
                            },
                            trailing: HStack {
                                NavigationLink(destination: MapView()) {
                                    Image(systemName: "map.fill")
                                        .foregroundColor(.blue)
                                }
                                NavigationLink(destination: NotificationsView()) {
                                    Image(systemName: "bell.fill")
                                        .foregroundColor(.blue)
                                }
                            
                            }
                        )
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    }
                }
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct TabItemView: View {
    let imageName: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            HeaderView()
            
            VStack(spacing: 20) {
                Spacer()
                
                SearchBarView()
                    .padding(.horizontal)
                
                CategoryBoxesView()
                    .padding(.horizontal)
                
                ImagesSectionView()
                    .padding(.horizontal)
                
                Text("Xplore around the world with ease")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .foregroundColor(.blue)

            }
            .background(Color.white)
            .cornerRadius(2)
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .tabItem {
            Image(systemName: imageName)
            Text(text)
        }
        .onAppear {
            self.action()
        }
    }
}

struct HeaderView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("Homepage") // Replace with your background image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipped()
            
            VStack(spacing: 10) {
                Text("Xplore the world today")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("XploreEase - take your Xploration to the next level")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

struct SearchBarView: View {
    var body: some View {
        HStack {
            TextField("Search...", text: .constant(""))
                .padding()
                .background(Color.gray)
                .bold()
                .cornerRadius(10)
                .padding(.trailing, 10)
            
            Button(action: {
                // Navigate to search results page
            }) {
                Text("Search")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
        }
        .background(Color.white) // Ensure the background is white
        .padding(.horizontal)
    }
}

struct CategoryBoxesView: View {
    var body: some View {
        HStack(spacing: 20) {
            NavigationLink(destination: HousingView()) {
                CategoryBoxView(title: "Housing", imageName: "Housing")
                
            }
            
            NavigationLink(destination: DiningView()) {
                CategoryBoxView(title: "Dining", imageName: "Dining")
            }
            
            NavigationLink(destination: RecreationView()) {
                CategoryBoxView(title: "Recreation", imageName: "Recreation")
            }
        }
        .background(Color.white) // Ensure the background is white
        .padding(.horizontal)
    }
}

struct CategoryBoxView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 100)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        }
        .frame(width: 120, height: 130)
        .background(Color.black)
        .cornerRadius(10)
        .shadow(radius: 20)
    }
}

import SwiftUI

struct ImagesSectionView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(1..<16) { index in
                    NavigationLink(destination: ImageDetailView(imageName: "Tropical", placeName: "Troical")) {
                        ImageBoxView(imageName: "Tropical", placeName: "Tropical")
                    }
                    NavigationLink(destination: ImageDetailView(imageName: "Cambodia", placeName: "Cambodia")){
                        ImageBoxView(imageName: "Cambodia", placeName: "Cambodia")
                    }
                    NavigationLink(destination: ImageDetailView(imageName: "Chi", placeName: "Chicago")){
                        ImageBoxView(imageName: "Chi", placeName: "Chicago")
                    }
                    NavigationLink(destination: ImageDetailView(imageName: "Toronto, Canada", placeName: "Toronto,Canada")){
                        ImageBoxView(imageName: "Toronto, Canada", placeName: "Toronto, Canada")
                    }
                    NavigationLink(destination: ImageDetailView(imageName: "New York", placeName: "New York")){
                        ImageBoxView(imageName: "New York", placeName: "New York")
                    }
                    NavigationLink(destination: ImageDetailView(imageName: "Japan", placeName: "Japan")){
                        ImageBoxView(imageName: "Japan", placeName: "Japan")
                    }
                    NavigationLink(destination: ImageDetailView(imageName: "New Jersey", placeName: "New Jersey")){
                        ImageBoxView(imageName: "New Jersey", placeName: "New Jersey")
                    }
                    NavigationLink(destination: ImageDetailView(imageName: "Thailand", placeName: "Thailand")){
                        ImageBoxView(imageName: "Thailand", placeName: "Thailand")
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(Color.white) // Ensure the background is white
    }
}

struct ImageBoxView: View {
    var imageName: String
    var placeName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            
            HStack {
                Image(systemName: "heart")
                    .foregroundColor(.red)
                    .padding(.trailing, 5)
                
                Text(placeName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .padding(.trailing, 5)
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .frame(width: 150)
    }
}

struct ImageDetailView: View {
    var imageName: String
    var placeName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .cornerRadius(10)
            
            Text(placeName)
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
        .navigationBarTitle("Image Detail", displayMode: .inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
