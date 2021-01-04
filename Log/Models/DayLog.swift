//
//  DayLog.swift
//  Log
//
//  Created by AzumaSato on 2020/12/29.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum LogState: Int, Codable {
  case task
  case event
  case memo
}

enum LogSubState: Int, Codable {
  case none
  case priority
  case idea
}

struct DayLog: Codable, Identifiable {
  // ID
  @DocumentID var id: String?
  // UserID
  var userId: String?
  // log の内容
  var log: String
  // LogState: 初期値Task
  var state: LogState
  // LogSubState: 初期値None
  var subState: LogSubState
  // DayLog の日にち
  var logDate: Timestamp
  // DayLog の作成日
  @ServerTimestamp var createdAt: Timestamp!
  // DayLog の更新日
  @ServerTimestamp var updatedAt: Timestamp!
  // DayLog の完了日
  var completedAt: Timestamp?
}

#if DEBUG
let testDayLogs = [
  DayLog(userId: "uuid12345", log: "Implement UI", state: .task, subState: .none, logDate: Timestamp()),
  DayLog(userId: "uuid23456", log: "Connect to Firebase", state: .task, subState: .none, logDate: Timestamp()),
  DayLog(userId: "uuid34567", log: "Sample!!!!!", state: .task, subState: .none, logDate: Timestamp()),
  DayLog(userId: "uuid45678", log: "?????????", state: .task, subState: .none, logDate: Timestamp()),
]
#endif
