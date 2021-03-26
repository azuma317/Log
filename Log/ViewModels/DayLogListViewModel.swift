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
  @Published var stateDayLogCellViewModels = [StateDayLogCellViewModel]()
  @Published var dateFormat: String = ""

  @Published private var dayLogRepository: DayLogRepository = Resolver.resolve()
  @Published private var settingsService: SettingsService = Resolver.resolve()

  private var cancellables = Set<AnyCancellable>()

  init() {
    self.stateDayLogCellViewModels = Dictionary(
      grouping: dayLogRepository.dayLogs,
      by: { (dayLog) -> LogState in
        dayLog.state
      }
    )
    .map { StateDayLogCellViewModel(stateDayLog: $0) }
    .sorted(by: { $0.id < $1.id })

    settingsService.$dateFormat
      .map { $0.format }
      .assign(to: \.dateFormat, on: self)
      .store(in: &cancellables)
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }

  func removeDayLog(dayLog: DayLog) {
    dayLogRepository.removeDayLog(dayLog)
  }
}
