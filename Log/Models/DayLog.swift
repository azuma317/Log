//
//  DayLog.swift
//  Log
//
//  Created by AzumaSato on 2020/12/29.
//

import Foundation

enum LogState: Int, Codable {
  case task
  case event
  case memo
  case complete
}

enum LogSubState: Int, Codable {
  case none
  case priority
  case idea
}

struct DayLog {
  // ID
  var id: String = UUID().uuidString
  // UserID
  var userId: String?
  // log の内容
  var log: String
  // LogState: 初期値Task
  var state: LogState
  // LogSubState: 初期値None
  var subState: LogSubState
  // DayLog の日にち
  var logDate: Date
  // DayLog の作成日
  var createdDate: Date
  // DayLog の更新日
  var updatedDate: Date
  // DayLog の完了日
  var completedDate: Date?
  // DayLog を削除した時間
  var deletedDate: Date?
}
