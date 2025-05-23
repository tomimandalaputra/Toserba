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
   var showAlert: Bool = false

   var displayTotalQuantity: Int {
      productsInCart.reduce(0) { $0 + $1.quantity }
   }

   var displayTotalCartPrice: Double {
      let totalPrice = productsInCart.reduce(0) { Double($1.quantity) * $1.product.price } 
      return totalPrice
   }

   func addToCart(product: Product) {
      if let indexOfProductInCart = productsInCart.firstIndex(where: { $0.id == product.id }) {
         let currentQuantity = productsInCart[indexOfProductInCart].quantity
         let newQuantity = currentQuantity + 1

         productsInCart[indexOfProductInCart] = ProductInCart(product: product, quantity: newQuantity)
      } else {
         productsInCart.append(ProductInCart(product: product, quantity: 1))
      }
   }

   func removeFromCart(product: Product) {
      if let indexOfProductInCart = productsInCart.firstIndex(where: { $0.id == product.id }) {
         let currentQuantity = productsInCart[indexOfProductInCart].quantity

         if currentQuantity > 1 {
            let newQuantity = currentQuantity - 1
            productsInCart[indexOfProductInCart] = ProductInCart(product: product, quantity: newQuantity)
         } else {
            productsInCart.remove(at: indexOfProductInCart)
         }
      }
   }
}
