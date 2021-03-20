//
//  DateFormat.swift
//  Log
//
//  Created by AzumaSato on 2021/02/24.
//

import Foundation
import SwiftDate

enum DateFormat: Int {
  case month_day
  case day_month
  case year_month

  var format: String {
    switch self {
    case .month_day:
      return "MMM d yyyy"
    case .day_month:
      return "d MMM yyyy"
    case .year_month:
      return "yyyy/M/d"
    }
  }

  var monthFormat: String {
    switch self {
    case .month_day:
      return "MMM yyyy"
    case .day_month:
      return "MMM yyyy"
    case .year_month:
      return "yyyy/M"
    }
  }

  var next: DateFormat {
    switch self {
    case .month_day:
      return .day_month
    case .day_month:
      return .year_month
    case .year_month:
      return .month_day
    }
  }

  var prev: DateFormat {
    switch self {
    case .month_day:
      return .year_month
    case .day_month:
      return .month_day
    case .year_month:
      return .day_month
    }
  }
}
