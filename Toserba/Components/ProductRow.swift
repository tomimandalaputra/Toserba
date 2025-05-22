//
//  ProductRow.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import SwiftUI

struct ProductRow: View {
   @Environment(FavoritesManager.self) private var favoritesManager: FavoritesManager

   let product: Product

   var body: some View {
      NavigationLink(destination: {
         ProductDetailView(product: product)
      }, label: {
         VStack(alignment: .leading, spacing: 4) {
            AsyncImage(url: URL(string: product.image)) { phase in
               switch phase {
                  case .empty:
                     ZStack {
                        Rectangle()
                           .fill(Color.surfaceCard)
                           .frame(width: 180, height: 180)
                           .clipShape(UnevenRoundedRectangle(topLeadingRadius: 14, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 14))

                        ProgressView().tint(Color.textMain)
                     }

                  case .success(let image):
                     image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 14, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 14))

                  case .failure:
                     ZStack {
                        Rectangle()
                           .fill(Color.surfaceCard)
                           .frame(width: 180, height: 180)
                           .clipShape(UnevenRoundedRectangle(topLeadingRadius: 14, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 14))

                        Image(systemName: "photo")
                     }

                  @unknown default:
                     EmptyView()
               }
            }

            Group {
               HStack(spacing: 2) {
                  Image(systemName: "star.fill")
                     .font(.system(size: 14))
                     .foregroundStyle(Color.warningTheme)

                  Text("\(product.rating.rate, specifier: "%.1f")")
                     .font(.system(size: 14, weight: .semibold))
                     .foregroundStyle(Color.secondaryTheme)

                  Text("(\(product.rating.count))")
                     .font(.system(size: 14, weight: .regular))
                     .foregroundStyle(Color.secondaryTheme)

                  Spacer()

                  Text("In stock")
                     .font(.system(size: 14, weight: .semibold))
                     .foregroundStyle(Color.successTheme)
               }.padding(.top, 4)

               Text(product.category)
                  .foregroundStyle(Color.secondaryTheme)
                  .font(.system(size: 12, weight: .medium))

               Text(product.title)
                  .font(.system(size: 14, weight: .semibold))
                  .foregroundStyle(Color.textMain)

               Spacer()

               Text("$\(product.price, specifier: "%.2f")")
                  .font(.system(size: 18, weight: .semibold))
                  .foregroundStyle(Color.textMain)
            }
            .padding(.horizontal, 8)

            Spacer()
         }
         .background(RoundedRectangle(cornerRadius: 12).fill(Color.surfaceCard))
         .frame(width: 180, height: 300)
         .overlay(alignment: .topTrailing, content: {
            Button(action: {
               if favoritesManager.products.contains(product) {
                  favoritesManager.products.removeAll(where: { $0.id == product.id })
               } else {
                  favoritesManager.products.append(product)
               }

            }, label: {
               Image(systemName: favoritesManager.products.contains(product) ? "heart.fill" : "heart")
                  .foregroundStyle(Color.errorTheme)
            })
            .padding(8)
         })
         .overlay {
            RoundedRectangle(cornerRadius: 12)
               .stroke(Color.border, lineWidth: 1)
         }
      })
   }
}

#Preview {
   NavigationStack {
      ProductRow(product: Product(id: 1, title: "Title", price: 10.00, description: "Description", category: "t-shirt", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 4.6, count: 200)))
         .environment(FavoritesManager())
   }
}
