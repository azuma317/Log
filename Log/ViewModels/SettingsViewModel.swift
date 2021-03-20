//
//  SettingsViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/01/03.
//

import Foundation
import Combine
import Resolver
import Firebase

class SettingsViewModel: ObservableObject {
  @Published var user: User?
  @Published var isAnonymous = true
  @Published var email: String = ""
  @Published var displayName: String = ""
  @Published var dateFormat: String = ""
  @Published var timeFormat: String = ""

  @Published private var authenticationService: AuthenticationService = Resolver.resolve()
  @Published private var settingsService: SettingsService = Resolver.resolve()

  private var cancellables = Set<AnyCancellable>()

  init() {
    authenticationService.$user
      .compactMap { $0?.isAnonymous }
      .assign(to: \.isAnonymous, on: self)
      .store(in: &cancellables)

    authenticationService.$user
      .compactMap { $0?.email }
      .assign(to: \.email, on: self)
      .store(in: &cancellables)

    authenticationService.$user
      .compactMap { $0?.displayName }
      .assign(to: \.displayName, on: self)
      .store(in: &cancellables)

    settingsService.$dateFormat
      .map { $0.format }
      .assign(to: \.dateFormat, on: self)
      .store(in: &cancellables)

    settingsService.$timeFormat
      .map { $0.format }
      .assign(to: \.timeFormat, on: self)
      .store(in: &cancellables)
  }

  func logout() {
    self.authenticationService.signOut()
  }

  func changeDateFormat() {
    self.settingsService.dateFormat = self.settingsService.dateFormat.next
  }

  func changeTimeFormat() {
    self.settingsService.timeFormat = self.settingsService.timeFormat.next
  }
}
