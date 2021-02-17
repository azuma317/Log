//
//  MonthlyLogListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/02/13.
//

import Foundation
import Combine
import Resolver
import SwiftDate

class MonthlyLogListViewModel: ObservableObject {
  @Published var dayLogRepository: DayLogRepository = Resolver.resolve()
  @Published var monthlyLogCellViewModels = [MonthlyLogCellViewModel]()

  private var cancellables = Set<AnyCancellable>()

  init() {
    dayLogRepository.$dayLogs
      .map { dayLogs in
        Dictionary(grouping: dayLogs) { (dayLog) -> DateInRegion in
          dayLog.logDate.dateValue().in(region: .current).dateAtStartOf(.day)
        }
        .map {
          MonthlyLogCellViewModel(dayLogs: $0)
        }
        .sorted(by: { $0.dayLogs.key < $1.dayLogs.key })
      }
      .assign(to: \.monthlyLogCellViewModels, on: self)
      .store(in: &cancellables)
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }

  func removeDayLog(dayLog: DayLog) {
    dayLogRepository.removeDayLog(dayLog)
  }
}
