//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by Simon Ng on 14/10/2022.
//

import SwiftUI

struct RestaurantListView: View {
    @State var restaurants = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei",  isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image : "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image:"posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney" , image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "S ydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
    var body: some View {
        List {
            ForEach(restaurants.indices, id: \.self) { index in
                BasicTextImageRow(restaurant: $restaurants[index])
//                FullImageRow(isFavorite: $restaurants[index].isFavorite,
//                             imageName: restaurants[index].image,
//                             name: restaurants[index].name,
//                             type: restaurants[index].type,
//                             location: restaurants[index].location
//                             )
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
        
        RestaurantListView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Restaurant List View (Dark)")
        
        let previewRestaurant = Restaurant(name: "cafedeadend", type: "Cafe", location: "Hong Kong", image: "cafedeadend", isFavorite: true)
        BasicTextImageRow(restaurant: .constant(previewRestaurant))
            .previewLayout(.sizeThatFits)
            .previewDisplayName("BasicTextImageRow")

        FullImageRow(isFavorite: .constant(true), imageName: "cafedeadend", name: "Cafe Deadend", type: "Cafe", location: "Hong Kong")
            .previewLayout(.sizeThatFits)
            .previewDisplayName("FullImageRow")
    }
}

struct BasicTextImageRow: View {
    // MARK: - ??????
    @Binding var restaurant: Restaurant
    
    // MARK: - State variables
    
    @State private var showOptions = false
    @State private var showError = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(restaurant.image)
                .resizable()
                .frame(width: 120, height: 118)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            if restaurant.isFavorite {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .confirmationDialog("What do you want to do?", isPresented: $showOptions, titleVisibility: .visible) {
            
            Button("Reserve a table") {
                self.showError.toggle()
            }
            
            if !self.restaurant.isFavorite {
                Button("Mark as Favorite") {
                    self.restaurant.isFavorite.toggle()
                }
            } else {
                Button("Remove from Favorite") {
                    self.restaurant.isFavorite.toggle()
                }
            }
        }
        .alert("Not yet avaliale", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text("Sorry, this feature is not avaliable yet. Please retry later.")
        }
    }
}

struct FullImageRow: View {
    @State private var showOption = false
    @State private var showError = false
    
    @Binding var isFavorite: Bool
    
    var imageName: String
    var name:String
    var type: String
    var location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(.title2, design: .rounded))
                    
                    Text(type)
                        .font(.system(.body, design: .rounded))
                    
                    Text(location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                Spacer()
                if isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)

        }
        .onTapGesture {
            showOption.toggle()
        }
        .confirmationDialog("What do you want to do?", isPresented: $showOption, titleVisibility: .visible) {
            Button("Reserve a Table") {
                showError.toggle()
            }
            if !self.isFavorite {
                Button("Mark as Favorite") {
                    self.isFavorite.toggle()
                }
            } else {
                Button("Remove from Favorite") {
                    self.isFavorite.toggle()
                }
            }
        }
        .alert("Not avaliable yet", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text("Sorry, this feature is not avaliable yet. Please retry later.")
        }
    }
}
