//
//  LogListView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/18.
//

import SwiftUI
import FirebaseFirestore
import SwiftDate

struct LogListView: View {

  @State var presentAddNewItem = false
  @State var showSettingsScreen = false
  @State var selectedIndex = 0

  private let pickerItems = ["Day", "Monthly", "Future"]

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text(Date().in(region: .current).toString(.date(.medium)))
          .fontWeight(.semibold)
          .padding([.leading, .bottom])

        ZStack {
          switch pickerItems[selectedIndex] {
          case "Day":
            DayLogListView()
          case "Monthly":
            EmptyView()
          case "Future":
            EmptyView()
          default:
            EmptyView()
          }

          FloatingButton() { state in
            print(state)
          }
        }

        SegmentedPicker(items: pickerItems, selection: $selectedIndex)
          .padding(.horizontal)
      }
      .navigationBarItems(trailing:
        Button(action: { self.showSettingsScreen.toggle() }, label: {
          Image(systemName: "gear")
        })
      )
      .navigationBarTitle(pickerItems[selectedIndex] + "Log")
      .sheet(isPresented: $showSettingsScreen, content: {
        SettingsView()
      })
      .sheet(isPresented: self.$presentAddNewItem, content: {
        AddTaskView(text: .constant(""))
      })
    }
  }
}

struct LogListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LogListView()
        .environment(\.colorScheme, .light)

      LogListView()
        .environment(\.colorScheme, .dark)
    }
  }
}

enum InputError: Error {
  case empty
}
