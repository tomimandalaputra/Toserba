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
   @State var tabManager = TabManager()

   var body: some Scene {
      WindowGroup {
         TabView(selection: $tabManager.selectedTab, content: {
            HomeView()
               .tabItem {
                  Image(systemName: "house.fill")
                  Text("Home")
               }
               .tag(1)

            CartView()
               .tabItem {
                  Image(systemName: "cart.fill")
                  Text("Cart")
               }
               .tag(2)

            FavoritesView()
               .tabItem {
                  Image(systemName: "heart.fill")
                  Text("Favorites")
               }
               .tag(3)
         })
         .environment(favoritesManager)
         .environment(cartManager)
         .environment(tabManager)
      }
   }
}
