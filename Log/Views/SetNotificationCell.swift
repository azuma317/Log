//
//  SetRepeatCell.swift
//  Log
//
//  Created by AzumaSato on 2021/02/04.
//

import SwiftUI

struct SetNotificationCell: View {
  var body: some View {
    HStack(spacing: 0) {
      Image(systemName: "bell")
        .frame(width: 16.0, height: 16.0)
        .padding(.vertical, 8.0)
        .padding(.trailing, 16.0)

      Text("Notification")

      Spacer()
    }
    .padding(.horizontal)
    .background(Color(.systemBackground))
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
