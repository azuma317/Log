//
//  MonthlyLogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/02/15.
//

import Combine
import Resolver

class MonthlyLogCellViewModel: ObservableObject {
  @Injected var dayLogRepository: DayLogRepository

  @Published var dayLogs: (key: String, value: [DayLog])

  private var cancellables = Set<AnyCancellable>()

  init(dayLogs: (key: String, value: [DayLog])) {
    self.dayLogs = dayLogs
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }

  func removeDayLog(dayLog: DayLog) {
    dayLogRepository.removeDayLog(dayLog)
  }
}
