//
//  GroupDayLogViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/03/05.
//

import Foundation
import Combine
import Resolver
import SwiftDate

class GroupDayLogViewModel: ObservableObject, Identifiable {
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
