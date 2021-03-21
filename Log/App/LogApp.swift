//
//  LogApp.swift
//  Log
//
//  Created by AzumaSato on 2020/11/29.
//

import Firebase
import Resolver
import SwiftUI

@main
struct LogApp: App {

  @LazyInjected var authenticationService: AuthenticationService

  init() {
    FirebaseApp.configure()
    authenticationService.signIn()
    UIScrollView.appearance().keyboardDismissMode = .onDrag
  }

  var body: some Scene {
    WindowGroup {
      LogListView()
    }
  }
}
