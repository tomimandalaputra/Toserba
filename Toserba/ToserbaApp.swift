//
//  ToserbaApp.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import SwiftUI

@main
struct ToserbaApp: App {
   @State var favoritesManager = FavoritesManager()
   @State var cartManager = CartManager()

   var body: some Scene {
      WindowGroup {
         TabView(content: {
            HomeView()
               .tabItem {
                  Image(systemName: "house.fill")
                  Text("Home")
               }
            CartView()
               .tabItem {
                  Image(systemName: "cart.fill")
                  Text("Cart")
               }
            FavoritesView()
               .tabItem {
                  Image(systemName: "heart.fill")
                  Text("Favorites")
               }
         })
         .environment(favoritesManager)
         .environment(cartManager)
      }
   }
}
