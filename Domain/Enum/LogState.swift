//
//  LogState.swift
//  Log
//
//  Created by AzumaSato on 2021/02/24.
//

import Foundation

public enum LogState: Int, Codable, CaseIterable, CustomStringConvertible {
  case task
  case event
  case memo

  public var description: String {
    switch self {
    case .task:
      return "Task"
    case .event:
      return "Event"
    case .memo:
      return "Memo"
    }
  }

  public var imageName: String {
    switch self {
    case .task:
      return "flag"
    case .event:
      return "calendar"
    case .memo:
      return "number"
    }
  }

  public var circleImageName: String {
    switch self {
    case .task:
      return "flag.circle"
    case .event:
      return "calendar.circle"
    case .memo:
      return "number.circle"
    }
  }

  public var circleFillImageName: String {
    switch self {
    case .task:
      return "flag.circle.fill"
    case .event:
      return "calendar.circle.fill"
    case .memo:
      return "number.circle.fill"
    }
  }
}
