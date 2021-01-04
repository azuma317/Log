//
//  DayLogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import Foundation
import Combine
import Resolver

class DayLogCellViewModel: ObservableObject, Identifiable {
  @Injected var dayLogRepository: DayLogRepository

  @Published var dayLog: DayLog
  @Published var completionStateIconName = ""

  var id: String = ""

  private var cancellables = Set<AnyCancellable>()

  static func newDayLog() -> DayLogCellViewModel {
    DayLogCellViewModel(dayLog: DayLog(log: "", state: LogState.task, subState: LogSubState.none))
  }

  init(dayLog: DayLog) {
    self.dayLog = dayLog

    $dayLog
      .map { $0.completedDate != nil ? "checkmark.circle.fill" : "circle" }
      .assign(to: \.completionStateIconName, on: self)
      .store(in: &cancellables)

    $dayLog
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)

    $dayLog
      .dropFirst()
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .sink { [weak self] dayLog in
        self?.dayLogRepository.updateDayLog(dayLog)
      }
      .store(in: &cancellables)
  }

}
