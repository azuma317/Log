//
//  DayLog.swift
//  Log
//
//  Created by AzumaSato on 2021/03/30.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

public struct DayLog: Codable, Identifiable {
  // ID
  @DocumentID public var id: String?
  // UserID
  public var userId: String?
  // log の内容
  public var log: String
  // 詳細説明
  public var description: String = ""
  // LogState: 初期値Task
  public var state: LogState
  // LogSubState: 初期値None
  public var subState: LogSubState
  // DayLog の日にち
  public var logDate: Timestamp
  // DayLog の作成日
  @ServerTimestamp public var createdAt: Timestamp!
  // DayLog の更新日
  @ServerTimestamp public var updatedAt: Timestamp!
  // DayLog の完了日
  public var completedAt: Timestamp?
}

extension DayLog: Equatable {
  public static func == (lhs: DayLog, rhs: DayLog) -> Bool {
    return lhs.id == rhs.id
  }
}

#if DEBUG
  let testDayLogs = [
    DayLog(
      userId: "uuid12345", log: "Implement UI", state: .task, subState: .none, logDate: Timestamp()),
    DayLog(
      userId: "uuid23456", log: "Connect to Firebase", state: .task, subState: .none,
      logDate: Timestamp()),
    DayLog(
      userId: "uuid34567", log: "Sample!!!!!", state: .task, subState: .none, logDate: Timestamp()),
    DayLog(
      userId: "uuid45678", log: "?????????", state: .task, subState: .none, logDate: Timestamp()),
  ]
#endif
