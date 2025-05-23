//
//  SquareImageModifier.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 23/05/2025.
//

import Foundation
import SwiftUI

extension Image {
   func squareImageModifier() -> some View {
      self
         .resizable()
         .aspectRatio(contentMode: .fill)
         .frame(width: 70, height: 70)
         .clipped()
   }
}
