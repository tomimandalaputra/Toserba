//
//  ProductInCart.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 23/05/2025.
//

import Foundation

struct ProductInCart: Identifiable {
   var id: Int {
      product.id
   }

   let product: Product
   var quantity: Int
}
