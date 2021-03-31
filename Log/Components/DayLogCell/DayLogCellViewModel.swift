//
//  DayLogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import Combine
import FirebaseFirestore
import Resolver
import UIKit

class DayLogCellViewModel: ObservableObject, Identifiable {
  @Injected var dayLogRepository: DayLogRepository

  @Published var dayLog: DayLog
  @Published var logStateIconName = ""
  @Published var subLogStateIconName = ""

  var id: String = ""

  private var cancellables = Set<AnyCancellable>()

  static func newDayLog(state: LogState) -> DayLogCellViewModel {
    DayLogCellViewModel(
      dayLog: DayLog(log: "", state: state, subState: .none, logDate: Timestamp()))
  }

  init(dayLog: DayLog) {
    self.dayLog = dayLog

    $dayLog
      .map {
        switch $0.state {
        case .task:
          if $0.completedAt != nil {
            return "xmark"
          }
          return "circle.fill"
        case .event:
          return "circle"
        case .memo:
          return "minus"
        }
      }
      .assign(to: \.logStateIconName, on: self)
      .store(in: &cancellables)

    $dayLog
      .map {
        switch $0.subState {
        case .none:
          return ""
        case .priority:
          return "star.fill"
        case .idea:
          return "exclamationmark"
        }
      }
      .assign(to: \.subLogStateIconName, on: self)
      .store(in: &cancellables)

    $dayLog
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }

  func addDayLog(dayLog: DayLog) {
    dayLogRepository.addDayLog(dayLog)
  }

  func removeDayLog(dayLog: DayLog) {
    dayLogRepository.removeDayLog(dayLog)
  }
}
