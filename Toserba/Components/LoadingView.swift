//
//  LoadingView.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 21/05/2025.
//

import SwiftUI

struct LoadingView: View {
   var body: some View {
      ZStack {
         Color.black.opacity(0.5).ignoresSafeArea()

         ProgressView().tint(Color.white)
      }
   }
}

#Preview {
   LoadingView()
}
