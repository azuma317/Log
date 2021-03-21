//
//  GroupDayLogCell.swift
//  Log
//
//  Created by AzumaSato on 2021/03/06.
//

import SwiftDate
import SwiftUI

struct GroupDayLogCell: View {

  @ObservedObject var groupDayLogCellVM: GroupDayLogCellViewModel

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      VStack {
        Text(groupDayLogCellVM.targetDate.weekdayName(.short))
        Text(String(groupDayLogCellVM.targetDate.day))
      }
      .padding(.leading)

      VStack {
        ForEach(groupDayLogCellVM.dayLogCellViewModels) { dayLogCellVM in
          DayLogCell(dayLogCellVM: dayLogCellVM) { dayLog in
            onEdit(dayLog)
          }
          .padding(.horizontal)
        }
      }
    }
    .padding(.top)
  }
}

struct GroupDayLogCell_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      GroupDayLogCell(groupDayLogCellVM: testGroupDayLogCellViewModels[0])
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      GroupDayLogCell(groupDayLogCellVM: testGroupDayLogCellViewModels[1])
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
