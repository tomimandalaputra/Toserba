//
//  ProductDetailView.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 22/05/2025.
//

import SwiftUI

struct ProductDetailView: View {
   let product: Product

   @Environment(CartManager.self) private var cartManager: CartManager

   var body: some View {
      AppScaffold {
         ScrollView {
            VStack(alignment: .leading) {
               AsyncImage(url: URL(string: product.image)) { phase in
                  switch phase {
                     case .empty:
                        ZStack {
                           Rectangle()
                              .fill(Color.surfaceCard)
                              .frame(width: UIScreen.main.bounds.width, height: 300)
                              .clipShape(UnevenRoundedRectangle(topLeadingRadius: 14, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 14))

                           ProgressView().tint(Color.textMain)
                        }

                     case .success(let image):
                        image
                           .resizable()
                           .aspectRatio(contentMode: .fill)
                           .frame(width: UIScreen.main.bounds.width, height: 300)
                           .clipped()

                     case .failure:
                        ZStack {
                           Rectangle()
                              .fill(Color.surfaceCard)
                              .frame(width: UIScreen.main.bounds.width, height: 300)
                              .clipShape(UnevenRoundedRectangle(topLeadingRadius: 14, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 14))

                           Image(systemName: "photo")
                        }

                     @unknown default:
                        EmptyView()
                  }
               }

               Group {
                  HStack(spacing: 2) {
                     Text(product.category)
                        .foregroundStyle(Color.secondaryTheme)
                        .font(.system(size: 12, weight: .medium))

                     Spacer()

                     Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.warningTheme)

                     Text("\(product.rating.rate, specifier: "%.1f")")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.secondaryTheme)

                     Text("(\(product.rating.count))")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.secondaryTheme)

                  }.padding(.vertical, 6)

                  Text("$\(product.price, specifier: "%.2f")")
                     .font(.system(size: 18, weight: .semibold))
                     .foregroundStyle(Color.textMain)
                     .padding(.bottom, 2)

                  Text(product.title)
                     .font(.system(size: 20, weight: .bold))
                     .foregroundStyle(Color.textMain)

                  Text(product.description)
                     .font(.system(size: 15))
                     .foregroundStyle(Color.textMain)
                     .padding(.bottom, 8)

                  Button(action: {
                     cartManager.addToCart(product: product)
                  }, label: {
                     Text("Add to cart")
                  })
                  .buttonStyle(PrimaryButtonStyle())
               }.padding(.horizontal)

               Spacer()
            }
         }
      }
   }
}

#Preview {
   ProductDetailView(product: Product(id: 1, title: "Title", price: 10.00, description: "Description", category: "t-shirt", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 4.6, count: 200))).environment(CartManager())
}
