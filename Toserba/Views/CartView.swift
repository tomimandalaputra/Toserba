//
//  CartView.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 22/05/2025.
//

import SwiftUI

struct CartView: View {
   @Environment(CartManager.self) var viewModel: CartManager

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
               .padding(.bottom, 1)

            Text("$\(productInCart.product.price, specifier: "%.2f")")
               .font(.system(size: 18, weight: .semibold))
               .foregroundStyle(Color.textMain)

            Stepper("Quantity \(productInCart.quantity)") {} onDecrement: {}
         }
      }
   }

   var body: some View {
      AppScaffold {
         VStack {
            List(viewModel.productsInCart) { productInCart in
               CartRow(productInCart: productInCart)
            }
         }
      }
   }
}

#Preview {
   CartView()
      .environment(CartManager())
}
