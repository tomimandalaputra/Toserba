//
//  BannerImageModifier.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import Foundation
import SwiftUI

extension Image {
   func bannerImageStyle() -> some View {
      self
         .resizable()
         .aspectRatio(contentMode: .fill)
         .frame(width: UIScreen.main.bounds.width, height: 300)
   }
}
