//
//  AppIconListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/02/28.
//

import Foundation

class AppIconListViewModel: ObservableObject {
  @Published var selectedIcon: AppIcon {
    didSet {
      UserDefaults.standard.appIcon = selectedIcon
    }
  }

  init() {
    selectedIcon = UserDefaults.standard.appIcon
  }
}
