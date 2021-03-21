//
//  StateDayLogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/03/20.
//

import Foundation

class StateDayLogCellViewModel: ObservableObject, Identifiable {
  typealias StateDayLog = (key: LogState, value: [DayLog])

  @Published var state: LogState
  @Published var dayLogViewModels: [DayLogCellViewModel]

  var id: Int = 0

  init(stateDayLog: StateDayLog) {
    self.id = stateDayLog.key.rawValue

    self.state = stateDayLog.key

    self.dayLogViewModels = stateDayLog.value.map {
      DayLogCellViewModel(dayLog: $0)
    }
  }
}

#if DEBUG
let testStateDayLogCellViewModels = [
  StateDayLogCellViewModel(stateDayLog: (key: LogState.task, value: testDayLogs)),
  StateDayLogCellViewModel(stateDayLog: (key: LogState.event, value: testDayLogs)),
  StateDayLogCellViewModel(stateDayLog: (key: LogState.memo, value: testDayLogs)),
]
#endif
