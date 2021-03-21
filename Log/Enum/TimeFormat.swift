//
//  TimeFormat.swift
//  Log
//
//  Created by AzumaSato on 2021/02/25.
//

import Foundation

enum TimeFormat: Int {
  case timeMeridiem
  case time

  var format: String {
    switch self {
    case .timeMeridiem:
      return "h:mm a"
    case .time:
      return "HH:mm"
    }
  }

  var next: TimeFormat {
    switch self {
    case .timeMeridiem:
      return .time
    case .time:
      return .timeMeridiem
    }
  }

  var prev: TimeFormat {
    switch self {
    case .timeMeridiem:
      return .time
    case .time:
      return .timeMeridiem
    }
  }
}
