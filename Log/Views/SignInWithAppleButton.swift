//
//  SignInWithAppleButton.swift
//  Log
//
//  Created by AzumaSato on 2021/01/02.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme

  var body: some View {
    Group {
      SignInWithAppleButtonInternal(colorScheme: colorScheme)
    }
  }
}

fileprivate struct SignInWithAppleButtonInternal: UIViewRepresentable {
  var colorScheme: ColorScheme

  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    switch colorScheme {
    case .light:
      return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    case .dark:
      return ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    @unknown default:
      return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
  }

  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
  }
}

struct SignInWithAppleButton_Previews: PreviewProvider {
  static var previews: some View {
    SignInWithAppleButton()
  }
}
