//
//  MonthlyLogListView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/13.
//

import SwiftUI

struct MonthlyLogListView: View {
  var animation: Namespace.ID

  @ObservedObject var dayLogListVM = DayLogListViewModel()

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    Text("Hello, World!")
  }
}

struct MonthlyLogListView_Previews: PreviewProvider {
  @Namespace static var animation
  static var previews: some View {
    Group {
      MonthlyLogListView(animation: animation)
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      MonthlyLogListView(animation: animation)
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
