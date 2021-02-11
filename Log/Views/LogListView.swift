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

  @State var presentAddTask = false
  @State var presentAddEvent = false
  @State var showSettingsScreen = false
  @State var selectedIndex = 0
  @State var updateDayLog: DayLog?
  @Namespace var animation

  private let pickerItems = ["Day", "Monthly", "Future"]

  var body: some View {
    ZStack {
      Color(.systemBackground)
        .edgesIgnoringSafeArea(.all)

      VStack(alignment: .leading) {
        HStack {
          VStack {
            Text(pickerItems[selectedIndex] + "Log")
              .font(.title)
              .fontWeight(.bold)
              .padding([.top, .leading])

            Text(Date().in(region: .current).toString(.date(.medium)))
              .fontWeight(.semibold)
              .padding([.leading, .bottom])
          }

          Spacer()

          Button(action: { self.showSettingsScreen.toggle() }, label: {
            Image(systemName: "gear")
          })
          .padding(.trailing)
        }

        ZStack {
          switch pickerItems[selectedIndex] {
          case "Day":
            DayLogListView(animation: animation) { (dayLog) in
              self.updateDayLog = dayLog
              switch dayLog.state {
              case .task:
                self.presentAddTask.toggle()
              case .event:
                self.presentAddEvent.toggle()
              case .memo:
                break
              }
            }
          case "Monthly":
            EmptyView()
          case "Future":
            EmptyView()
          default:
            EmptyView()
          }

          FloatingButton() { state in
            withAnimation {
              switch state {
              case .task:
                self.presentAddTask.toggle()
              case .event:
                self.presentAddEvent.toggle()
              case .memo:
                break
              }
            }
          }
        }

        SegmentedPicker(items: pickerItems, selection: $selectedIndex)
      }
      .opacity(presentAddTask && presentAddEvent ? 0 : 1)

      if presentAddTask {
        AddTaskView(
          animation: animation,
          dayLogCellVM:
            (updateDayLog != nil) ?
            DayLogCellViewModel(dayLog: updateDayLog!) :
            DayLogCellViewModel.newDayLog(),
          presentAddTask: $presentAddTask
        )
      }
      if presentAddEvent {
        AddEventView(
          text: .constant(""),
          description: .constant("Add description"),
          presentAddEvent: $presentAddEvent,
          animation: animation
        )
      }
    }
    .sheet(isPresented: $showSettingsScreen) {
      SettingsView()
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
