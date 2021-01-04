//
//  LogCellViewModel.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import Foundation
import Combine
import Resolver

class LogCellViewModel: ObservableObject, Identifiable {
  @Injected var dayLogRepository: DayLogRepository

  @Published var dayLog: DayLog
  @Published var completionStateIconName = ""

  var id: String = ""

  private var cancellables = Set<AnyCancellable>()

  static func newDayLog() -> DayLog {
    
  }

}
