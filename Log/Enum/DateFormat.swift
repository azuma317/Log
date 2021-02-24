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

  var format: String {
    switch self {
    case .month_day:
      return "MMM dd yyyy"
    case .day_month:
      return "dd MMM yyyy"
    }
  }

}
