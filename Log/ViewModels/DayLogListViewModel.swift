//
//  DayLogListViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import Foundation
import Combine
import Resolver

class DayLogListViewModel: ObservableObject {
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

  func removeDayLogs(atOffsets indexSet: IndexSet) {
    // remove from repo
    let viewModels = indexSet.lazy.map { self.dayLogCellViewModels[$0] }
    viewModels.forEach { dayLogCellViewModel in
      dayLogRepository.removeDayLog(dayLogCellViewModel.dayLog)
    }
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }
}
