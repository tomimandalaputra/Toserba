//
//  CartManager.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 23/05/2025.
//

import Foundation

@Observable
class CartManager {
   var productsInCart: [ProductInCart] = []

   func addToCart(product: Product) {
      if let indexOfProductInCart = productsInCart.firstIndex(where: { $0.id == product.id }) {
         let currentQuantity = productsInCart[indexOfProductInCart].quantity
         let newQuantity = currentQuantity + 1

         productsInCart[indexOfProductInCart] = ProductInCart(product: product, quantity: newQuantity)
      } else {
         productsInCart.append(ProductInCart(product: product, quantity: 1))
      }
   }
}
