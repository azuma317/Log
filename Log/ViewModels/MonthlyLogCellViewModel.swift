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
  @Published var dayLogRepository: DayLogRepository = Resolver.resolve()
  @Published var targetDate: DateInRegion
  @Published var groupDayLogViewModels = [GroupDayLogCellViewModel]()

  var id: String = ""

  private var cancellables = Set<AnyCancellable>()

  init(date: DateInRegion) {
    self.id = date.toFormat("yyyy-MM")
    
    self.targetDate = date

    dayLogRepository.$dayLogs
      .map { dayLogs in
        Dictionary(
          grouping: dayLogs.filter {
            $0.logDate.dateValue().in(region: .current).toFormat("yyyy-MM") == self.targetDate.toFormat("yyyy-MM")
          }) { (dayLog) -> DateInRegion in
          dayLog.logDate.dateValue().in(region: .current).dateAtStartOf(.day)
        }
        .map { GroupDayLogCellViewModel(groupDayLog: $0) }
        .sorted(by: { $0.id < $1.id })
      }
      .assign(to: \.groupDayLogViewModels, on: self)
      .store(in: &cancellables)
  }
}

#if DEBUG
let testMonthlyLogCellViewModels = [
  MonthlyLogCellViewModel(date: (Date()-1.months).in(region: .current)),
  MonthlyLogCellViewModel(date: Date().in(region: .current)),
  MonthlyLogCellViewModel(date: (Date()+1.months).in(region: .current)),
]
#endif
