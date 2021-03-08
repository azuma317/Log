//
//  MonthlyLogCell.swift
//  Log
//
//  Created by AzumaSato on 2021/02/16.
//

import SwiftUI
import SwiftDate

struct MonthlyLogCell: View {

  @ObservedObject var monthlyLogCellVM: MonthlyLogCellViewModel

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    VStack(alignment: .leading) {
      Text(monthlyLogCellVM.targetDate.toFormat("yyyy-MM"))
        .fontWeight(.semibold)
        .padding([.top, .leading])

      ForEach(monthlyLogCellVM.groupDayLogViewModels) { groupDayLogVM in
        GroupDayLogCell(groupDayLogCellVM: groupDayLogVM){ dayLog in
          onEdit(dayLog)
        }
      }
    }
  }
}

struct MonthlyLogCell_Previews: PreviewProvider {
  @Namespace static var animation
  static var previews: some View {
    Group {
      MonthlyLogCell(monthlyLogCellVM: testMonthlyLogCellViewModels[0])
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      MonthlyLogCell(monthlyLogCellVM: testMonthlyLogCellViewModels[1])
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
