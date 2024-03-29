//
//  AppThemeListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/02/28.
//

import Combine
import Foundation

class AppThemeListViewModel: ObservableObject {
  @Published var selectedTheme: AppTheme {
    didSet {
      UserDefaults.standard.appTheme = selectedTheme
    }
  }

  init() {
    selectedTheme = UserDefaults.standard.appTheme
  }
}
