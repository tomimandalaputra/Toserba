//
//  ProductModel.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import Foundation

struct Product: Codable, Identifiable {
   let id: Int
   let title: String
   let price: Double
   let description: String
   let category: String
   let image: String
   let rating: Rating

   init(id: Int, title: String, price: Double, description: String, category: String, image: String, rating: Rating) {
      self.id = id
      self.title = title
      self.price = price
      self.description = description
      self.category = category
      self.image = image
      self.rating = rating
   }
}

extension Product: Hashable {
   func hash(into hasher: inout Hasher) {
      hasher.combine(id)
   }
}

struct Rating: Codable, Equatable {
   let rate: Double
   let count: Int
}
