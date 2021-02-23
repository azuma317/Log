//
//  SetRepeatCell.swift
//  Log
//
//  Created by AzumaSato on 2021/02/04.
//

import SwiftUI
import SwiftDate

struct SetNotificationCell: View {
  var body: some View {
    HStack(spacing: 0) {
      Image(systemName: "bell")
        .frame(width: 16.0, height: 16.0)
        .padding(.vertical, 8.0)
        .padding(.trailing, 16.0)

      Button(action: { self.setNotification() }, label: {
        Text("Add a notification")
      })

      Spacer()
    }
    .padding(.horizontal)
    .background(Color(.systemBackground))
  }

  func setNotification() {
    let localNotificationManager = LocalNotificationManager()
    localNotificationManager.requestPermission()
    localNotificationManager.addNotification(title: "title", subtitle: "subtitle", body: "body")
    localNotificationManager.scheduleNotification(date: Date()+1.minutes)
  }
}

struct SetNotificationCell_Previews: PreviewProvider {
  static var previews: some View {
    SetNotificationCell()
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .light)

    SetNotificationCell()
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .dark)
  }
}
