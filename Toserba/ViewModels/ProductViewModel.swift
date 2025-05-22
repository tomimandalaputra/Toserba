//
//  ProductViewModel.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import Foundation

@Observable
class ProductViewModel {
   var products: [Product] = []
   var isLoading: Bool = false
   var showAlert: Bool = false
   var alertMessage: String = ""
   var showAllProducts: Bool = false

   var categories: [String] {
      Array(Set(self.products.map { $0.category })).sorted()
   }

   func productGroupByCategory(for category: String, limited: Bool) -> [Product] {
      self.products.filter { $0.category == category }
   }

   func fetchProdcuts() {
      guard let url = URL(string: "https://fakestoreapi.com/products") else {
         self.alertMessage = "Invalid URL"
         self.showAlert = true
         return
      }

      self.isLoading = true

      URLSession.shared.dataTask(with: url) { data, _, error in
         DispatchQueue.main.async {
            self.isLoading = false

            if let error = error {
               self.alertMessage = error.localizedDescription
               self.showAlert = true
               return
            }

            guard let data = data else {
               self.alertMessage = "No data received"
               self.showAlert = true
               return
            }

            do {
               let products = try JSONDecoder().decode([Product].self, from: data)
               self.products = products
            } catch {
               self.alertMessage = "Decoding error: \(error.localizedDescription)"
               self.showAlert = true
            }
         }
      }.resume()
   }
}
