//
//  TwoColumnGrid.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 22/05/2025.
//

import Foundation
import SwiftUI

struct TwoColumnGrid<Content: View>: View {
   let columns = [
      GridItem(.flexible()),
      GridItem(.flexible())
   ]

   @ViewBuilder var content: () -> Content

   var body: some View {
      ScrollView {
         LazyVGrid(columns: columns, spacing: 16) {
            content()
         }
      }
   }
}
