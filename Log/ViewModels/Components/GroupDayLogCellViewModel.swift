//
//  GroupDayLogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/03/05.
//

import Combine
import Foundation
import Resolver
import SwiftDate

class GroupDayLogCellViewModel: ObservableObject, Identifiable {
  typealias GroupDayLog = (key: DateInRegion, value: [DayLog])

  @Published var targetDate: DateInRegion
  @Published var dayLogCellViewModels = [DayLogCellViewModel]()

  var id: String = ""

  init(groupDayLog: GroupDayLog) {
    self.id = groupDayLog.key.toFormat("yyyy-MM-dd")

    self.targetDate = groupDayLog.key

    self.dayLogCellViewModels = groupDayLog.value.map {
      DayLogCellViewModel(dayLog: $0)
    }
  }
}

#if DEBUG
  let testGroupDayLogCellViewModels = [
    GroupDayLogCellViewModel(
      groupDayLog: (key: (Date() - 1.days).in(region: .current), value: testDayLogs)),
    GroupDayLogCellViewModel(groupDayLog: (key: Date().in(region: .current), value: testDayLogs)),
    GroupDayLogCellViewModel(
      groupDayLog: (key: (Date() + 1.days).in(region: .current), value: testDayLogs)),
  ]
#endif
