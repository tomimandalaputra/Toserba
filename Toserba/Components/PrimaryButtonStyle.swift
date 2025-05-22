//
//  PrimaryButtonStyle.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
      configuration
         .label
         .font(.system(size: 14, weight: .bold))
         .foregroundStyle(Color.textMain)
         .frame(maxWidth: .infinity)
         .frame(height: 48)
         .background(Color.border)
         .clipShape(RoundedRectangle(cornerRadius: 12))
   }
}
