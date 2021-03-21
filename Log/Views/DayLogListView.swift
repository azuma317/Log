//
//  DayLogListView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import FirebaseFirestore
import SwiftDate
import SwiftUI

struct DayLogListView: View {
  @ObservedObject var dayLogListVM = DayLogListViewModel()

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    ScrollView {
      ForEach(dayLogListVM.stateDayLogCellViewModels) { stateDayLogCellVM in
        StateDayLogCell(stateDayLogCellVM: stateDayLogCellVM)
      }
    }
    .background(Color(.systemBackground))
  }
}

struct DayLogListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      DayLogListView()
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      DayLogListView()
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
