//
//  AppThemeListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/02/28.
//

import Foundation
import Combine

class AppThemeListViewModel: ObservableObject {
  @Published var selectedTheme: AppTheme = .light

  init() {
  }
}
