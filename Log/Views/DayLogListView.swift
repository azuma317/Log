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
    let taskDayLogViewModels = dayLogListVM.dayLogCellViewModels
      .filter { $0.dayLog.state == .task }
    let eventDayLogViewModels = dayLogListVM.dayLogCellViewModels
      .filter { $0.dayLog.state == .event }
    let memoDayLogViewModels = dayLogListVM.dayLogCellViewModels
      .filter { $0.dayLog.state == .memo }

    ScrollView {
      HStack {
        Text("Task")
          .padding(.leading)

        Spacer()
      }
      .padding(.top)

      ForEach(taskDayLogViewModels.indices, id: \.self) { index in
        ZStack {
          HStack {
            Spacer()

            Button(action: {
              dayLogListVM.removeDayLog(dayLog: taskDayLogViewModels[index].dayLog)
            }) {
              Image(systemName: "trash")
                .font(.title)
                .foregroundColor(Color(.secondaryLabel))
                .frame(width: 64)
            }

          }

          DayLogCell(animation: animation, dayLogCellVM: taskDayLogViewModels[index]) { dayLog in
            onEdit(dayLog)
          }
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

      ForEach(eventDayLogViewModels.indices, id: \.self) { index in
        ZStack {
          HStack {
            Spacer()

            Button(action: {
              dayLogListVM.removeDayLog(dayLog: eventDayLogViewModels[index].dayLog)
            }) {
              Image(systemName: "trash")
                .font(.title)
                .foregroundColor(Color(.secondaryLabel))
                .frame(width: 64)
            }

          }

          DayLogCell(animation: animation, dayLogCellVM: eventDayLogViewModels[index])
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

      ForEach(memoDayLogViewModels.indices, id: \.self) { index in
        ZStack {
          HStack {
            Spacer()

            Button(action: {
              dayLogListVM.removeDayLog(dayLog: memoDayLogViewModels[index].dayLog)
            }) {
              Image(systemName: "trash")
                .font(.title)
                .foregroundColor(Color(.secondaryLabel))
                .frame(width: 64)
            }

          }

          DayLogCell(animation: animation, dayLogCellVM: memoDayLogViewModels[index])
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
