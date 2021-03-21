//
//  DateFormat.swift
//  Log
//
//  Created by AzumaSato on 2021/02/24.
//

import Foundation
import SwiftDate

enum DateFormat: Int {
  case monthDay
  case dayMonth
  case yearMonth

  var format: String {
    switch self {
    case .monthDay:
      return "MMM d yyyy"
    case .dayMonth:
      return "d MMM yyyy"
    case .yearMonth:
      return "yyyy/M/d"
    }
  }

  var monthFormat: String {
    switch self {
    case .monthDay:
      return "MMM yyyy"
    case .dayMonth:
      return "MMM yyyy"
    case .yearMonth:
      return "yyyy/M"
    }
  }

  var next: DateFormat {
    switch self {
    case .monthDay:
      return .dayMonth
    case .dayMonth:
      return .yearMonth
    case .yearMonth:
      return .monthDay
    }
  }

  var prev: DateFormat {
    switch self {
    case .monthDay:
      return .yearMonth
    case .dayMonth:
      return .monthDay
    case .yearMonth:
      return .dayMonth
    }
  }
}
