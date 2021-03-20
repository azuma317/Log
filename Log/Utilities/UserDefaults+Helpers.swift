//
//  UserDefaults+Helpers.swift
//  Log
//
//  Created by AzumaSato on 2021/03/01.
//

import Foundation
import SwiftUI

struct UserDefaultsKeys {
  static let appTheme = "apptheme"
  static let appIcon = "appicon"
  static let dateFormat = "dateformat"
  static let timeFormat = "timeformat"
}

extension UserDefaults {
  func reset() {
  }

  var appTheme: AppTheme {
    get { AppTheme(rawValue: integer(forKey: UserDefaultsKeys.appTheme)) ?? .light }
    set { set(newValue.rawValue, forKey: UserDefaultsKeys.appTheme) }
  }

  var appIcon: AppIcon {
    get { AppIcon(rawValue: integer(forKey: UserDefaultsKeys.appIcon)) ?? .white }
    set { set(newValue.rawValue, forKey: UserDefaultsKeys.appIcon) }
  }

  var dateFormat: DateFormat {
    get { DateFormat(rawValue: integer(forKey: UserDefaultsKeys.dateFormat)) ?? .month_day }
    set { set(newValue.rawValue, forKey: UserDefaultsKeys.dateFormat) }
  }

  var timeFormat: TimeFormat {
    get { TimeFormat(rawValue: integer(forKey: UserDefaultsKeys.timeFormat)) ?? .time_meridiem }
    set { set(newValue.rawValue, forKey: UserDefaultsKeys.timeFormat) }
  }
}
