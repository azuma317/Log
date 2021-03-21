//
//  DayLogListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import Foundation
import Combine
import Resolver
import FirebaseFirestore
import SwiftDate

class DayLogListViewModel: ObservableObject {
  @Published var dayLogRepository: DayLogRepository = Resolver.resolve()
  @Published var stateDayLogCellViewModels = [StateDayLogCellViewModel]()

  private var cancellables = Set<AnyCancellable>()

  init() {
    self.stateDayLogCellViewModels = Dictionary(grouping: dayLogRepository.dayLogs, by: { (dayLog) -> LogState in
      dayLog.state
    })
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
