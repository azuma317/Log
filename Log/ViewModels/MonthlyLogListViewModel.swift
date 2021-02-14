//
//  MonthlyLogListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/02/13.
//

import Foundation
import Combine
import Resolver

class MonthlyLogListViewModel: ObservableObject {
  @Published var dayLogRepository: DayLogRepository = Resolver.resolve()
  @Published var dayLogCellViewModels = [DayLogCellViewModel]()

  private var cancellables = Set<AnyCancellable>()

  init() {
    dayLogRepository.$dayLogs.map { dayLogs in
      dayLogs.map { dayLog in
        DayLogCellViewModel(dayLog: dayLog)
      }
    }
    .assign(to: \.dayLogCellViewModels, on: self)
    .store(in: &cancellables)
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }

  func removeDayLog(dayLog: DayLog) {
    dayLogRepository.removeDayLog(dayLog)
  }
}
