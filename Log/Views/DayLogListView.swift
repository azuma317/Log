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

  var body: some View {
    Form {
      Section(header: Text("Task")) {
        ForEach(
          dayLogListVM.dayLogCellViewModels
            .filter { $0.dayLog.state == .task }) { dayLogCellVM in
          DayLogCell(dayLogCellVM: dayLogCellVM)
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
      }
      .listRowBackground(Color(.secondarySystemBackground))

      Section(header: Text("Event")) {
        ForEach(
          dayLogListVM.dayLogCellViewModels
            .filter { $0.dayLog.state == .event }) { dayLogCellVM in
          DayLogCell(dayLogCellVM: dayLogCellVM)
        }
        .onDelete(perform: { indexSet in
          self.dayLogListVM.removeDayLogs(atOffsets: indexSet)
        })
      }
      .listRowBackground(Color(.secondarySystemBackground))

      Section(header: Text("Memo")) {
        ForEach(
          dayLogListVM.dayLogCellViewModels
            .filter { $0.dayLog.state == .memo }) { dayLogCellVM in
          DayLogCell(dayLogCellVM: dayLogCellVM)
        }
        .onDelete(perform: { indexSet in
          self.dayLogListVM.removeDayLogs(atOffsets: indexSet)
        })
      }
      .listRowBackground(Color(.secondarySystemBackground))
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
  }
}
