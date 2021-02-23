//
//  LocalNotificationManager.swift
//  Log
//
//  Created by AzumaSato on 2021/02/21.
//

import UserNotifications
import SwiftDate

struct Notification {
  var id: String
  var title: String
  var subtitle: String?
  var body: String
}

class LocalNotificationManager {
  var notifications = [Notification]()

  func requestPermission() -> Void {
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .badge]) { (granted, error) in
        if granted && error == nil {
        }
      }
  }

  func addNotification(title: String, subtitle: String?, body: String) -> Void {
    notifications.append(Notification(id: UUID().uuidString, title: title, subtitle: subtitle, body: body))
  }

  func scheduleNotification(date: Date) -> Void {
    for notification in notifications {
      let content = UNMutableNotificationContent()
      content.title = notification.title
      if let subtitle = notification.subtitle {
        content.subtitle = subtitle
      }
      content.body = notification.body
      print(date.in(region: .current).dateComponents)

      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
      let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

      UNUserNotificationCenter.current().add(request) { (error) in
        guard error == nil else { print(error!); return }
      }
    }
  }
}
