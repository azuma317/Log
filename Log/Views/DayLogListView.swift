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
  @State var selectedIndex = 0

  private let pickerItems: [String] = ["Day", "Monthly", "Feature"]

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text("2021/01/01")
          .fontWeight(.semibold)
          .padding(.leading)

        Form {
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

        HStack {
          Spacer()

          Button(action: { self.presentAddNewItem.toggle() }, label: {
            HStack {
              Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
            }
          })
          .padding(.init(top: 8.0, leading: 0, bottom: 0, trailing: 16.0))
          .accentColor(Color(UIColor.systemRed))
          .sheet(isPresented: self.$presentAddNewItem, content: {
            SettingsView()
          })
        }
        .background(Color.clear)

        SegmentedPicker(items: pickerItems, selection: $selectedIndex)
          .padding()
      }
      .navigationBarItems(trailing:
        Button(action: {
          self.showSettingsScreen.toggle()
        }, label: {
          Image(systemName: "gear")
        })
      )
      .navigationBarTitle(pickerItems[selectedIndex] + "Log")
      .sheet(isPresented: $showSettingsScreen, content: {
        SettingsView()
      })
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

enum InputError: Error {
  case empty
}

struct DayLogCell: View {
  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  var onCommit: (Result<DayLog, InputError>) -> Void = { _ in }

  var body: some View {
    Section {
      HStack {
        Image(systemName: dayLogCellVM.completionStateIconName)
          .resizable()
          .frame(width: 20, height: 20)
          .onTapGesture {
            let isCompeted = self.dayLogCellVM.dayLog.completedAt != nil
            self.dayLogCellVM.dayLog.completedAt = isCompeted ? nil : Timestamp()
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
    }
    .listRowBackground(Color(.secondarySystemBackground))
  }
}
