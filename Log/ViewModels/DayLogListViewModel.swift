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
  @Published var taskDayLogCellViewModels = [DayLogCellViewModel]()
  @Published var eventDayLogCellViewModels = [DayLogCellViewModel]()
  @Published var memoDayLogCellViewModels = [DayLogCellViewModel]()

  private var cancellables = Set<AnyCancellable>()

  init() {
    dayLogRepository.$dayLogs
      .map { dayLogs in
        dayLogs.filter { dayLog in
          dayLog.state == .task
        }
        .map { dayLog in
          DayLogCellViewModel(dayLog: dayLog)
        }
      }
      .assign(to: \.taskDayLogCellViewModels, on: self)
      .store(in: &cancellables)

    dayLogRepository.$dayLogs
      .map { dayLogs in
        dayLogs.filter { dayLog in
          dayLog.state == .event
        }
        .map { dayLog in
          DayLogCellViewModel(dayLog: dayLog)
        }
      }
      .assign(to: \.eventDayLogCellViewModels, on: self)
      .store(in: &cancellables)

    dayLogRepository.$dayLogs
      .map { dayLogs in
        dayLogs.filter { dayLog in
          dayLog.state == .memo
        }
        .map { dayLog in
          DayLogCellViewModel(dayLog: dayLog)
        }
      }
      .assign(to: \.memoDayLogCellViewModels, on: self)
      .store(in: &cancellables)
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }

  func removeDayLog(dayLog: DayLog) {
    dayLogRepository.removeDayLog(dayLog)
  }
}
