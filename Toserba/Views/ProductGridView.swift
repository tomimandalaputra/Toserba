//
//  ProductGridView.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import SwiftUI

struct ProductGridView: View {
   let products: [Product]

   var body: some View {
      AppScaffold {
         VStack {
            TwoColumnGrid {
               ForEach(products) { product in
                  ProductRow(product: product)
               }
            }
         }
      }
   }
}

#Preview {
   ProductGridView(products: [
      Product(id: 1, title: "Title", price: 10.00, description: "Description", category: "t-shirt", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 4.6, count: 200))
   ])
}
