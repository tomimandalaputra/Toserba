//
//  FavoritesView.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 22/05/2025.
//

import SwiftUI

struct FavoritesView: View {
   @Environment(FavoritesManager.self) private var favoritesManager: FavoritesManager

   fileprivate func FavoriteProductRow(product: Product) -> some View {
      HStack {
         AsyncImage(url: URL(string: product.image)) { phase in
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
            Text(product.title)
               .font(.system(size: 15, weight: .bold))
               .padding(.bottom, 1)

            Text(product.description)
               .font(.system(size: 15, weight: .bold))
               .lineLimit(2)
         }

         Spacer()

         Button(action: {
            favoritesManager.products.removeAll(where: { $0.id == product.id })
         }, label: {
            Image(systemName: "heart.fill")
               .foregroundStyle(Color.errorTheme)
         })
      }
      .listRowBackground(Color.surfaceCard)
   }

   var body: some View {
      AppScaffold {
         VStack {
            List(favoritesManager.products) { product in
               FavoriteProductRow(product: product)
            }
            .scrollContentBackground(.hidden)
         }
         .overlay {
            if favoritesManager.products.isEmpty {
               Text("Noting to see here")
                  .foregroundStyle(Color.textMain)
            }
         }
      }
   }
}

#Preview {
   FavoritesView()
      .environment(FavoritesManager())
}
