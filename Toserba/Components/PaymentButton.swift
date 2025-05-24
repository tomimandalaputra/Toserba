//
//  PaymentButton.swift
//  Toserba
//
//  Created by Tomi Mandala Putra on 24/05/2025.
//

import PassKit
import SwiftUI

struct PaymentButton: UIViewRepresentable {
   let button = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .automatic)
   var action: () -> Void

   func makeUIView(context: Context) -> UIView {
      return button
   }

   func updateUIView(_ uiView: UIView, context: Context) {}

   func makeCoordinator() -> Coordinator {
      Coordinator(button: button, action: action)
   }

   class Coordinator: NSObject {
      var action: () -> Void

      init(button: PKPaymentButton, action: @escaping () -> Void) {
         self.action = action
         super.init()
         button.addTarget(self, action: #selector(callback), for: .touchUpInside)
      }

      @objc func callback() {
         action()
      }
   }
}
