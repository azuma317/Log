//
//  MonthlyLogListView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/13.
//

import SwiftUI

struct MonthlyLogListView: View {
  @ObservedObject var monthlyLogListVM = MonthlyLogListViewModel()

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    ScrollView {
      ForEach(monthlyLogListVM.monthlyLogCellViewModels) { monthlyLogCellVM in
        MonthlyLogCell(monthlyLogCellVM: monthlyLogCellVM) { dayLog in
          onEdit(dayLog)
        }
      }
    }
  }
}

struct MonthlyLogListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MonthlyLogListView()
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      MonthlyLogListView()
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
