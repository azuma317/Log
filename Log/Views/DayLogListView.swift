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
  @ObservedObject var dayLogListVM = DayLogListViewModel()

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

          DayLogCell(dayLogCellVM: taskDayLogViewModels[index])
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

          DayLogCell(dayLogCellVM: eventDayLogViewModels[index])
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

          DayLogCell(dayLogCellVM: memoDayLogViewModels[index])
        }
        .padding(.horizontal)
        .padding(.top, 8.0)
      }
    }
  }
}

struct DayLogListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      DayLogListView()
        .environment(\.colorScheme, .light)

      DayLogListView()
        .environment(\.colorScheme, .dark)
    }
  }
}

struct DayLogCell: View {
  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  var onCommit: (Result<DayLog, InputError>) -> Void = { _ in }

  @GestureState var isDragging = false

  var body: some View {
    HStack {
      if dayLogCellVM.subLogStateIconName != "" {
        Image(systemName: dayLogCellVM.subLogStateIconName)
          .frame(width: 20, height: 20)
      } else {
        Image(systemName: dayLogCellVM.logStateIconName)
          .frame(width: 20, height: 20)
      }

      Divider()

      TextField("Enter title", text: $dayLogCellVM.dayLog.log,
                onCommit: {
                  if !self.dayLogCellVM.dayLog.log.isEmpty {
                    self.onCommit(.success(self.dayLogCellVM.dayLog))
                  } else {
                    self.onCommit(.failure(.empty))
                  }
                }).id(dayLogCellVM.dayLog.id)
    }
    .padding()
    .background(Color(.secondarySystemBackground))
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 4)
    .shadow(color: Color.black.opacity(0.2), radius: 4, x: -4, y: -4)
    .offset(x: dayLogCellVM.offset)
    .gesture(
      DragGesture()
        .updating($isDragging, body: { (value, state, _) in
          state = true
          onChanged(value: value, viewModel: dayLogCellVM)
        })
        .onEnded({ value in
          onEnded(value: value, viewModel: dayLogCellVM)
        })
    )
  }

  private func onChanged(value: DragGesture.Value, viewModel: DayLogCellViewModel) {
    if value.translation.width < 0 && isDragging {
      if value.translation.width > -64 {
        viewModel.offset = value.translation.width
      } else {
        viewModel.offset = -64 - (log(-63-value.translation.width) * 4)
      }
    }
  }

  private func onEnded(value: DragGesture.Value, viewModel: DayLogCellViewModel) {
    withAnimation {
      if value.translation.width <= -56 {
        viewModel.offset = -64
      } else {
        viewModel.offset = 0
      }
    }
  }
}
