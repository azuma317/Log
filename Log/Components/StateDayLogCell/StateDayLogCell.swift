//
//  StateDayLogCell.swift
//  Log
//
//  Created by AzumaSato on 2021/03/20.
//

import SwiftUI

struct StateDayLogCell: View {
  @ObservedObject var stateDayLogCellVM: StateDayLogCellViewModel

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    VStack {
      HStack {
        Text(stateDayLogCellVM.state.description)
          .padding(.leading)

        Spacer()
      }
      .padding(.top)

      ForEach(stateDayLogCellVM.dayLogViewModels) { dayLogVM in
        DayLogCell(dayLogCellVM: dayLogVM) { dayLog in
          onEdit(dayLog)
        }
        .padding(.horizontal)
      }
    }
  }
}

struct StateDayLogCell_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StateDayLogCell(stateDayLogCellVM: testStateDayLogCellViewModels[0])
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      StateDayLogCell(stateDayLogCellVM: testStateDayLogCellViewModels[1])
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
