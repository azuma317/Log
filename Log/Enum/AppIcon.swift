//
//  AppIcon.swift
//  Log
//
//  Created by AzumaSato on 2021/03/01.
//

import Foundation

enum AppIcon: Int, CustomStringConvertible, CaseIterable {
  case white
  case black
  case polar

  var description: String {
    switch self {
    case .white:
      return "White"
    case .black:
      return "Black"
    case .polar:
      return "Polar"
    }
  }
}
