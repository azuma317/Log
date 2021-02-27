//
//  AppTheme.swift
//  Log
//
//  Created by AzumaSato on 2021/02/26.
//

import Foundation

enum AppTheme: Int, CustomStringConvertible, CaseIterable {
  case light
  case dark

  var description: String {
    switch self {
    case .light:
      return "light"
    case .dark:
      return "dark"
    }
  }
}
