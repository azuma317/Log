//
//  SettingsService.swift
//  Log
//
//  Created by AzumaSato on 2021/03/15.
//

import Foundation

class SettingsService: ObservableObject {
  @Published var dateFormat: DateFormat {
    didSet {
      UserDefaults.standard.dateFormat = dateFormat
    }
  }
  @Published var timeFormat: TimeFormat {
    didSet {
      UserDefaults.standard.timeFormat = timeFormat
    }
  }

  init() {
    self.dateFormat = UserDefaults.standard.dateFormat
    self.timeFormat = UserDefaults.standard.timeFormat
  }
}
