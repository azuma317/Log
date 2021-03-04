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
  @Injected var dayLogRepository: DayLogRepository
  @Published var targetDate: Date
  @Published var dayLogCellViewModels = [DayLogCellViewModel]()

  var id: String = ""

  private var cancellables = Set<AnyCancellable>()

  init(date: Date) {
    self.targetDate = date

    dayLogRepository.$dayLogs
      .map { dayLogs in
        dayLogs.filter({
          $0.logDate.dateValue().toString(.custom("yyyy-MM-dd")) == date.toString(.custom("yyyy-MM-dd"))
        })
        .map {
          DayLogCellViewModel(dayLog: $0)
        }
        .sorted(by: { $0.dayLog.createdAt.dateValue() < $1.dayLog.createdAt.dateValue() })
      }
      .assign(to: \.dayLogCellViewModels, on: self)
      .store(in: &cancellables)
  }
}
