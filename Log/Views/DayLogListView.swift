//
//  DayLogListView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import SwiftUI
import FirebaseFirestore

struct DayLogListView: View {
  @ObservedObject var dayLogListVM = DayLogListViewModel()

  @State var presentAddNewItem = false
  @State var showSettingsScreen = false

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        List {
          ForEach (dayLogListVM.dayLogCellViewModels) { dayLogCellVM in
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
        .listStyle(PlainListStyle())

        Button(action: { self.presentAddNewItem.toggle() }, label: {
          HStack {
            Image(systemName: "plus.circle.fill")
              .resizable()
              .frame(width: 20, height: 20)

            Text("New DayLog")
          }
        })
        .padding()
        .accentColor(Color(UIColor.systemRed))
      }
      .navigationBarItems(trailing:
        Button(action: {
          self.showSettingsScreen.toggle()
        }, label: {
          Image(systemName: "gear")
        })
      )
      .navigationBarTitle("DayLog")
      .sheet(isPresented: $showSettingsScreen, content: {
        SettingsView()
      })
    }
  }
}

struct DayLogListView_Previews: PreviewProvider {
  static var previews: some View {
    DayLogListView()
  }
}

enum InputError: Error {
  case empty
}

struct DayLogCell: View {
  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  var onCommit: (Result<DayLog, InputError>) -> Void = { _ in }

  var body: some View {
    HStack {
      Image(systemName: dayLogCellVM.completionStateIconName)
        .resizable()
        .frame(width: 20, height: 20)
        .onTapGesture {
          self.dayLogCellVM.dayLog.completedAt = Timestamp()
        }

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
