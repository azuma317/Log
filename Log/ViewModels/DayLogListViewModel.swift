//
//  DayLogListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import Combine
import FirebaseFirestore
import Foundation
import Resolver
import SwiftDate

class DayLogListViewModel: ObservableObject {
  @Published var dateDescription = ""
  @Published var stateDayLogCellViewModels = [StateDayLogCellViewModel]()

  @Published private var dayLogRepository: DayLogRepository = Resolver.resolve()
  @Published private var settingsService: SettingsService = Resolver.resolve()

  private var cancellables = Set<AnyCancellable>()

  init() {
    self.dateDescription = Date().in(region: .current).toFormat(settingsService.dateFormat.format)

    self.stateDayLogCellViewModels = Dictionary(
      grouping: dayLogRepository.dayLogs,
      by: { (dayLog) -> LogState in
        dayLog.state
      }
    )
    .map { StateDayLogCellViewModel(stateDayLog: $0) }
    .sorted(by: { $0.id < $1.id })
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }

  func removeDayLog(dayLog: DayLog) {
    dayLogRepository.removeDayLog(dayLog)
  }
}
