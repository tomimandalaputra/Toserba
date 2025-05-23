//
//  HomeView.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import SwiftUI

struct HomeView: View {
   @State private var viewModel = ProductViewModel()
   @Environment(CartManager.self) private var cartManager: CartManager
   @Environment(TabManager.self) private var tabManager: TabManager

   fileprivate var NavigationBarView: some View {
      HStack {
         Text("TOSERBA")
            .font(.system(size: 24, weight: .black))
            .foregroundStyle(Color.textMain)

         Spacer()
      }
      .overlay(alignment: .trailing) {
         Button(action: {
            tabManager.selectedTab = 2
         }, label: {
            ZStack {
               Image(systemName: "cart.fill")
                  .foregroundStyle(Color.textMain)

               if cartManager.productsInCart.count > 0 {
                  ZStack {
                     Circle()
                        .foregroundStyle(Color.errorTheme)
                        .frame(width: 24, height: 24)

                     Text("\(cartManager.displayTotalQuantity)")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.white)
                  }.offset(CGSize(width: 12, height: -12))
               }
            }
         }).padding(.trailing, 12)
      }
   }

   var body: some View {
      NavigationStack {
         AppScaffold {
            VStack {
               NavigationBarView
                  .padding(.horizontal)

               ScrollView {
                  Image("banner")
                     .bannerImageStyle()

                  ForEach(viewModel.categories, id: \.self) { category in
                     Group {
                        HStack {
                           Text(category.capitalized)
                              .font(.system(size: 18, weight: .semibold))
                              .foregroundStyle(Color.textMain)

                           Spacer()
                        }
                        .padding(.top)

                        ScrollView(.horizontal) {
                           HStack {
                              ForEach(viewModel.productGroupByCategory(for: category, limited: true)) { product in
                                 ProductRow(product: product)
                              }
                           }
                        }
                     }.padding(.horizontal, 12)
                  }

                  Button(action: {
                     viewModel.showAllProducts = true
                  }, label: {
                     Text("Show all products")
                  })
                  .buttonStyle(PrimaryButtonStyle())
                  .padding(.horizontal)
                  .padding(.top)
               }

               Spacer()
            }.padding(.horizontal)

            if viewModel.isLoading {
               LoadingView()
            }
         }
         .navigationDestination(isPresented: $viewModel.showAllProducts, destination: {
            ProductGridView(products: viewModel.products)
         })
         .alert("Something Went Wrong", isPresented: $viewModel.showAlert) {
            Button(action: {}, label: {
               Text("OK")
            })
         } message: {
            Text(viewModel.alertMessage)
         }
      }
      .task {
         viewModel.fetchProdcuts()
      }
   }
}

#Preview {
   HomeView()
      .environment(CartManager())
      .environment(TabManager())
}
