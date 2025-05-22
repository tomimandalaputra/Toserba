//
//  AppScaffold.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import SwiftUI

struct AppScaffold<Content: View>: View {
   @ViewBuilder let content: () -> Content

   var body: some View {
      ZStack {
         Color.backgroundTheme.ignoresSafeArea()
         content()
      }
   }
}
