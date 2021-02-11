//
//  DayLogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import UIKit
import Combine
import Resolver
import FirebaseFirestore

class DayLogCellViewModel: ObservableObject, Identifiable {
  @Injected var dayLogRepository: DayLogRepository

  @Published var dayLog: DayLog
  @Published var logStateIconName = ""
  @Published var subLogStateIconName = ""
  @Published var offset: CGFloat = 0

  var id: String = ""

  private var cancellables = Set<AnyCancellable>()

  static func newDayLog() -> DayLogCellViewModel {
    DayLogCellViewModel(dayLog: DayLog(log: "", state: .task, subState: .none, logDate: Timestamp()))
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

//    $dayLog
//      .dropFirst()
//      .debounce(for: 0.8, scheduler: RunLoop.main)
//      .sink { [weak self] dayLog in
//        self?.dayLogRepository.updateDayLog(dayLog)
//      }
//      .store(in: &cancellables)
  }

}
