//
//  LogSubState.swift
//  Log
//
//  Created by AzumaSato on 2021/02/24.
//

import Foundation

enum LogSubState: Int, Codable, CustomStringConvertible {
  case none
  case priority
  case idea

  var description: String {
    switch self {
    case .none:
      return "None"
    case .priority:
      return "Priority"
    case .idea:
      return "Idea"
    }
  }
}
