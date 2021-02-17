//
//  MonthlyLogCell.swift
//  Log
//
//  Created by AzumaSato on 2021/02/16.
//

import SwiftUI

struct MonthlyLogCell: View {

  @ObservedObject var monthlyLogCellVM: MonthlyLogCellViewModel

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      VStack {
        Text(monthlyLogCellVM.dayLogs.key.weekdayName(.short))
        Text(String(monthlyLogCellVM.dayLogs.key.day))
      }
      .padding([.leading, .top])

      VStack {
        ForEach(monthlyLogCellVM.dayLogs.value) { dayLogCellVM in
          DayLogCell(dayLogCellVM: dayLogCellVM){ dayLog in
            onEdit(dayLog)
          }
          .padding(.horizontal)
          .padding(.top, 8.0)
        }
      }
    }
    .padding(.bottom)
  }
}

struct MonthlyLogCell_Previews: PreviewProvider {
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
