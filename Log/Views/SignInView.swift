//
//  SignInView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/02.
//

import SwiftUI
import Firebase
import AuthenticationServices
import CryptoKit

struct SignInView: View {
  @Environment(\.window) var window: UIWindow?
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  @State var signInHandler: SignInWithAppleCoordinator?

  var body: some View {
    VStack {
      Image("")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding(.horizontal, 100)
        .padding(.top, 100)
        .padding(.bottom, 50)

      HStack {
        Text("Welcom to")
          .font(.title)

        Text("ReLog")
          .font(.title)
          .fontWeight(.semibold)
      }

      Text("Create an account to save your tasks and access them anywhere.")
        .font(.headline)
        .fontWeight(.medium)
        .multilineTextAlignment(.center)
        .padding(.top, 20)

      Spacer()

      SignInWithAppleButton()
        .frame(width: 280, height: 45)
        .onTapGesture {
          self.signInWithAppleButtonTapped()
        }

      Divider()
        .padding(.horizontal, 15)
        .padding(.top, 20)
        .padding(.bottom, 15)

      Text("By using ReLog you agree to our Terms of Use and Service Policy")
        .multilineTextAlignment(.center)
    }
  }

  func signInWithAppleButtonTapped() {
    signInHandler = SignInWithAppleCoordinator(window: self.window)
    signInHandler?.link(onSignedInHandler: { (user) in
      print("User signed in. UID: \(user.uid), email: \(user.email ?? "(empty)")")
      self.presentationMode.wrappedValue.dismiss()
    })
  }
}

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView()
  }
}
