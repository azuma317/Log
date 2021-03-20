//
//  MonthlyLogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/02/15.
//

import Foundation
import Combine
import Resolver
import SwiftDate

class MonthlyLogCellViewModel: ObservableObject, Identifiable {
  typealias MonthlyLog = (key: DateInRegion, value: [DayLog])

  @Published var targetDate: DateInRegion
  @Published var groupDayLogViewModels = [GroupDayLogCellViewModel]()
  @Published var monthFormat: String = ""

  @Published private var settingsService: SettingsService = Resolver.resolve()

  var id: String = ""

  private var cancellables = Set<AnyCancellable>()

  init(monthlyLog: MonthlyLog) {
    self.id = monthlyLog.key.toFormat("yyyy-MM")
    
    self.targetDate = monthlyLog.key

    self.groupDayLogViewModels = Dictionary(grouping: monthlyLog.value, by: { (dayLog) -> DateInRegion in
      dayLog.logDate.dateValue().in(region: .current).dateAtStartOf(.day)
    })
    .map { GroupDayLogCellViewModel(groupDayLog: $0) }
    .sorted(by: { $0.id < $1.id })

    settingsService.$dateFormat
      .map { $0.monthFormat }
      .assign(to: \.monthFormat, on: self)
      .store(in: &cancellables)
  }
}

#if DEBUG
let testMonthlyLogCellViewModels = [
  MonthlyLogCellViewModel(monthlyLog: (key: (Date()-1.months).in(region: .current), value: testDayLogs)),
  MonthlyLogCellViewModel(monthlyLog: (key: Date().in(region: .current), value: testDayLogs)),
  MonthlyLogCellViewModel(monthlyLog: (key: (Date()+1.months).in(region: .current), value: testDayLogs)),
]
#endif
