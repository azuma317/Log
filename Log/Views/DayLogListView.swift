//
//  DayLogListView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import SwiftUI
import FirebaseFirestore
import SwiftDate

struct DayLogListView: View {
  var animation: Namespace.ID

  @ObservedObject var dayLogListVM = DayLogListViewModel()

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    ScrollView {
      HStack {
        Text("Task")
          .padding(.leading)

        Spacer()
      }
      .padding(.top)

      ForEach(dayLogListVM.taskDayLogCellViewModels.indices, id: \.self) { index in
        DayLogCell(animation: animation, dayLogCellVM: dayLogListVM.taskDayLogCellViewModels[index]) { dayLog in
          onEdit(dayLog)
        }
        .padding(.horizontal)
        .padding(.top, 8.0)
      }

      HStack {
        Text("Event")
          .padding(.leading)

        Spacer()
      }
      .padding(.top)

      ForEach(dayLogListVM.eventDayLogCellViewModels.indices, id: \.self) { index in
        DayLogCell(animation: animation, dayLogCellVM: dayLogListVM.eventDayLogCellViewModels[index]) { dayLog in
          onEdit(dayLog)
        }
        .padding(.horizontal)
        .padding(.top, 8.0)
      }

      HStack {
        Text("Memo")
          .padding(.leading)

        Spacer()
      }
      .padding(.top)

      ForEach(dayLogListVM.memoDayLogCellViewModels.indices, id: \.self) { index in
        DayLogCell(animation: animation, dayLogCellVM: dayLogListVM.memoDayLogCellViewModels[index]) { dayLog in
          onEdit(dayLog)
        }
        .padding(.horizontal)
        .padding(.top, 8.0)
      }
    }
    .background(Color(.systemBackground))
  }
}

struct DayLogListView_Previews: PreviewProvider {
  @Namespace static var animation
  static var previews: some View {
    Group {
      DayLogListView(animation: animation)
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      DayLogListView(animation: animation)
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
