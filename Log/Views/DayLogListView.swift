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

  @Binding var presentAddNewItem: Bool

  @GestureState var isDragging = false

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

      ForEach(taskDayLogViewModels.indices) { index in
        ZStack {
          Color(.blue)
            .cornerRadius(10)

          Color(.red)
            .cornerRadius(10)
            .padding(.trailing, 64)

          HStack {
            Spacer()

            Button(action: {}) {
              Image(systemName: "trash")
                .font(.title)
                .foregroundColor(Color(.secondaryLabel))
                .frame(width: 64)
            }
          }

          DayLogCell(dayLogCellVM: taskDayLogViewModels[index])
            .offset(x: dayLogListVM.dayLogCellViewModels[index].offset)
            .gesture(
              DragGesture()
                .updating($isDragging, body: { (value, state, _) in
                  state = true
                  onChanged(value: value, index: index)
                })
                .onEnded({ value in
                  onEnded(value: value, index: index)
                })
            )
        }
        .padding(.horizontal)
        .padding(.top, 8.0)
      }
      .onDelete(perform: { indexSet in
        self.dayLogListVM.removeDayLogs(atOffsets: indexSet)
      })
      if presentAddNewItem {
        DayLogCell(dayLogCellVM: DayLogCellViewModel.newDayLog()) { result in
          if case .success(let dayLog) = result {
            self.dayLogListVM.addDayLog(dayLog: dayLog)
          }
          self.presentAddNewItem.toggle()
        }
      }

      HStack {
        Text("Event")
          .padding(.leading)

        Spacer()
      }
      .padding(.top)

      ForEach(eventDayLogViewModels.indices) { index in
        ZStack {
          Color(.blue)
            .cornerRadius(10)

          Color(.red)
            .cornerRadius(10)
            .padding(.trailing, 40)

          DayLogCell(dayLogCellVM: eventDayLogViewModels[index])
        }
        .padding(.horizontal)
        .padding(.top, 8.0)
      }
      .onDelete(perform: { indexSet in
        self.dayLogListVM.removeDayLogs(atOffsets: indexSet)
      })

      HStack {
        Text("Memo")
          .padding(.leading)

        Spacer()
      }
      .padding(.top)

      ForEach(memoDayLogViewModels.indices) { index in
        ZStack {
          Color(.blue)
            .cornerRadius(10)

          Color(.red)
            .cornerRadius(10)
            .padding(.trailing, 40)

          DayLogCell(dayLogCellVM: memoDayLogViewModels[index])
        }
        .padding(.horizontal)
        .padding(.top, 8.0)
      }
      .onDelete(perform: { indexSet in
        self.dayLogListVM.removeDayLogs(atOffsets: indexSet)
      })
    }
  }

  private func onChanged(value: DragGesture.Value, index: Int) {
    if value.translation.width < 0 && isDragging {
      dayLogListVM.dayLogCellViewModels[index].$offset = value.translation.width
    }
  }

  private func onEnded(value: DragGesture.Value, index: Int) {
    withAnimation {
      if value.translation.width <= -100 {
        dayLogListVM.dayLogCellViewModels[index].offset = -130
      } else {
        dayLogListVM.dayLogCellViewModels[index].offset = 0
      }
    }
  }
}

struct DayLogListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      DayLogListView(presentAddNewItem: .constant(false))
        .environment(\.colorScheme, .light)

      DayLogListView(presentAddNewItem: .constant(false))
        .environment(\.colorScheme, .dark)
    }
  }
}

struct DayLogCell: View {
  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  var onCommit: (Result<DayLog, InputError>) -> Void = { _ in }

  var body: some View {
    HStack {
      if dayLogCellVM.subLogStateIconName != "" {
        Image(systemName: dayLogCellVM.subLogStateIconName)
          .frame(width: 20, height: 20)
      }

      Image(systemName: dayLogCellVM.logStateIconName)
        .frame(width: 20, height: 20)

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
  }
}
