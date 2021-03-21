//
//  MonthlyLogListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/03/06.
//

import Combine
import Foundation
import Resolver
import SwiftDate

class MonthlyLogListViewModel: ObservableObject {
  @Published var dayLogRepository: DayLogRepository = Resolver.resolve()
  @Published var targetDate = Date().in(region: .current)
  @Published var monthlyLogCellViewModels = [MonthlyLogCellViewModel]()

  private var cancellables = Set<AnyCancellable>()

  init() {
    dayLogRepository.$dayLogs
      .map { dayLogs in
        Dictionary(grouping: dayLogs) { (dayLogs) -> DateInRegion in
          dayLogs.logDate.dateValue().in(region: .current).dateAtStartOf(.month)
        }
        .map { MonthlyLogCellViewModel(monthlyLog: $0) }
        .sorted(by: { $0.id < $1.id })
      }
      .assign(to: \.monthlyLogCellViewModels, on: self)
      .store(in: &cancellables)
  }
}
