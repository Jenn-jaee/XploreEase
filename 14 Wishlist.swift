import SwiftUI

struct WishlistItem: Identifiable {
        let id = UUID()
        let title: String
}

class WishlistManager: ObservableObject {
        @Published var wishlistItems: [WishlistItem] = []
        
        func addItem(_ item: WishlistItem) {
                wishlistItems.append(item)
            }
        
        func removeItem(_ item: WishlistItem) {
                if let index = wishlistItems.firstIndex(where: { $0.id == item.id }) {
                        wishlistItems.remove(at: index)
                    }
            }
        
        func isItemInWishlist(_ item: WishlistItem) -> Bool {
                return wishlistItems.contains(where: { $0.id == item.id })
            }
}

struct WishlistView: View {
        @ObservedObject var wishlistManager = WishlistManager()
        
        var body: some View {
                NavigationView {
                        ZStack {
                                Color.white
                                    .edgesIgnoringSafeArea(.all)
                                
                                VStack {
                                        Text("Wishlist")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .padding()
                                        
                                        if wishlistManager.wishlistItems.isEmpty {
                                                Text("Your wishlist is empty")
                                                    .foregroundColor(.gray)
                                                    .padding()
                                            } else {
                                                    List {
                                                            ForEach(wishlistManager.wishlistItems) { item in
                                                                    Text(item.title)
                                                                }
                                                            .onDelete(perform: removeItems)
                                                        }
                                                }
                                    }
                            }
                        .navigationBarTitle("Wishlist", displayMode: .inline)
                        .navigationBarItems(trailing: EditButton())
                    }
                .environmentObject(wishlistManager) // Pass WishlistManager to the environment
            }
        
        // Function to remove items from the wishlist
        func removeItems(at offsets: IndexSet) {
                wishlistManager.wishlistItems.remove(atOffsets: offsets)
            }
}

struct WishlistView_Previews: PreviewProvider {
        static var previews: some View {
                WishlistView()
            }
}
