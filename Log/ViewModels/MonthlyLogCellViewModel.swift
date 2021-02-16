//
//  MonthlyLogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/02/15.
//

import Combine
import Resolver

class MonthlyLogCellViewModel: ObservableObject, Identifiable {
  @Injected var dayLogRepository: DayLogRepository

  @Published var dayLogs: (key: String, value: [DayLogCellViewModel])

  var id: String = ""

  private var cancellables = Set<AnyCancellable>()

  init(dayLogs: (key: String, value: [DayLog])) {
    self.dayLogs = (key: dayLogs.key, value: dayLogs.value.map { DayLogCellViewModel(dayLog: $0) })

    id = dayLogs.key
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }

  func removeDayLog(dayLog: DayLog) {
    dayLogRepository.removeDayLog(dayLog)
  }
}
