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
  @Published var dayLogCellViewModels = [DayLogCellViewModel]()

  private var cancellables = Set<AnyCancellable>()

  init() {
    dayLogRepository.$dayLogs.map { dayLogs in
      dayLogs.filter { dayLog in
        return dayLog.logDate.dateValue() >= Date().dateAt(.startOfDay) && dayLog.logDate.dateValue() < (Date().dateAt(.tomorrowAtStart))
      }.map { dayLog in
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

  func removeDayLogs(atOffsets indexSet: IndexSet) {
    // remove from repo
    let viewModels = indexSet.lazy.map { self.dayLogCellViewModels[$0] }
    viewModels.forEach { dayLogCellViewModel in
      removeDayLog(dayLog: dayLogCellViewModel.dayLog)
    }
  }
}
