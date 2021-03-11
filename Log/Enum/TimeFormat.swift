//
//  TimeFormat.swift
//  Log
//
//  Created by AzumaSato on 2021/02/25.
//

import Foundation

enum TimeFormat: Int {
  case time_meridiem
  case time

  var format: String {
    switch self {
    case .time_meridiem:
      return "h:mm a"
    case .time:
      return "HH:mm"
    }
  }

  var next: TimeFormat {
    switch self {
    case .time_meridiem:
      return .time
    case .time:
      return .time_meridiem
    }
  }

  var prev: TimeFormat {
    switch self {
    case .time_meridiem:
      return .time
    case .time:
      return .time_meridiem
    }
  }
}
