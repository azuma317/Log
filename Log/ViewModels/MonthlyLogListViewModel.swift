//
//  MonthlyLogListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/03/06.
//

import Foundation
import SwiftDate

class MonthlyLogListViewModel: ObservableObject {
  @Published var targetDate = Date().in(region: .current)
  @Published var monthlyLogCellViewModels = [MonthlyLogCellViewModel]()

  init() {
    
  }
}
