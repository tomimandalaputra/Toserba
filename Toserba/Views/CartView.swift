//
//  CartView.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 22/05/2025.
//

import SwiftUI

struct CartView: View {
   @Environment(CartManager.self) var cartManager: CartManager

   fileprivate func CartRow(productInCart: ProductInCart) -> some View {
      HStack {
         AsyncImage(url: URL(string: productInCart.product.image)) { phase in
            switch phase {
               case .empty:
                  ZStack {
                     Rectangle()
                        .fill(Color.surfaceCard)
                        .frame(width: 70, height: 70)

                     ProgressView().tint(Color.textMain)
                  }

               case .success(let image):
                  image
                     .squareImageModifier()

               case .failure:
                  ZStack {
                     Rectangle()
                        .fill(Color.surfaceCard)
                        .frame(width: 70, height: 70)

                     Image(systemName: "photo")
                  }

               @unknown default:
                  EmptyView()
            }
         }

         VStack(alignment: .leading) {
            Text(productInCart.product.title)
               .font(.system(size: 15, weight: .bold))
               .foregroundStyle(Color.textMain)
               .padding(.bottom, 1)

            Text("$\(productInCart.product.price, specifier: "%.2f")")
               .font(.system(size: 18, weight: .semibold))
               .foregroundStyle(Color.textMain)

            Stepper("Quantity \(productInCart.quantity)") {
               cartManager.addToCart(product: productInCart.product)
            } onDecrement: {
               cartManager.removeFromCart(product: productInCart.product)
            }
         }
      }
   }

   var body: some View {
      AppScaffold {
         VStack {
            List(cartManager.productsInCart) { productInCart in
               CartRow(productInCart: productInCart)
            }
            .scrollContentBackground(.hidden)

            VStack {
               Divider()
               HStack {
                  Text("Total: \(cartManager.displayTotalQuantity)")
                     .font(.system(size: 16, weight: .medium))
                     .foregroundStyle(Color.textMain)

                  Spacer()

                  Text("$\(cartManager.displayTotalCartPrice, specifier: "%.2f")")
                     .font(.system(size: 16, weight: .bold))
                     .foregroundStyle(Color.textMain)
               }
               .padding(.horizontal)
               .padding(.vertical, 24)

               PaymentButton(action: cartManager.pay)
                  .frame(height: 48)
                  .clipShape(RoundedRectangle(cornerRadius: 12))
                  .padding(.horizontal, 16)
                  .padding(.bottom, 30)
            }
         }
         .overlay {
            if cartManager.productsInCart.isEmpty {
               Text("Noting to see here")
                  .foregroundStyle(Color.textMain)
            }
         }
      }
   }
}

#Preview {
   CartView()
      .environment(CartManager())
}
