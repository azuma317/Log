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

  @State var presentSelectLog = false
  @State var presentAddTask = false
  @State var presentAddEvent = false
  @State var presentAddMemo = false
  @State var showSettingsScreen = false
  @State var selectedIndex = 0
  @State var updateDayLog: DayLog?
  @Namespace var animation

  private let pickerItems = ["Day", "Monthly"]

  var body: some View {
    ZStack {
      Color(.systemBackground)
        .edgesIgnoringSafeArea(.all)

      VStack(alignment: .leading) {
        HStack {
          VStack(alignment: .leading) {
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
          // DayLogListView or MonthlyLogListView
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
                self.presentAddMemo.toggle()
              }
            }
          case "Monthly":
            MonthlyLogListView(animation: animation) { (dayLog) in
              self.updateDayLog = dayLog
              switch dayLog.state {
              case .task:
                self.presentAddTask.toggle()
              case .event:
                self.presentAddEvent.toggle()
              case .memo:
                self.presentAddMemo.toggle()
              }
            }
          default:
            EmptyView()
          }

          // AddButton
          HStack {
            Spacer()

            VStack {
              Spacer()

              Button(action: {
                withAnimation {
                  self.presentSelectLog.toggle()
                }
              }, label: {
                HStack {
                  Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 56.0, height: 56.0)
                    .background(Color(.secondarySystemBackground))
                }
              })
              .accentColor(Color(UIColor.systemRed))
              .cornerRadius(28.0)
            }
          }
          .padding(.init(top: 0, leading: 0, bottom: 8.0, trailing: 16.0))
        }

        // SegmentPicker
        SegmentedPicker(items: pickerItems, selection: $selectedIndex)
      }
      .opacity(presentAddTask && presentAddEvent ? 0 : 1)

      // SelectLogView
      if presentSelectLog {
        SelectLogView(presentSelectLog: $presentSelectLog) { state in
          self.updateDayLog = nil
          withAnimation {
            switch state {
            case .task:
              self.presentAddTask.toggle()
            case .event:
              self.presentAddEvent.toggle()
            case .memo:
              self.presentAddMemo.toggle()
            }
          }
        }
      }

      // AddTaskView
      if presentAddTask {
        AddTaskView(
          animation: animation,
          dayLogCellVM:
            (updateDayLog != nil) ?
            DayLogCellViewModel(dayLog: updateDayLog!) :
            DayLogCellViewModel.newDayLog(state: .task),
          presentAddTask: $presentAddTask
        )
      }

      // AddEventView
      if presentAddEvent {
        AddEventView(
          animation: animation,
          dayLogCellVM:
            (updateDayLog != nil) ?
            DayLogCellViewModel(dayLog: updateDayLog!) :
            DayLogCellViewModel.newDayLog(state: .event),
          presentAddEvent: $presentAddEvent
        )
      }

      // AddMemoView
      if presentAddMemo {
        AddMemoView(
          animation: animation,
          dayLogCellVM:
            (updateDayLog != nil) ?
            DayLogCellViewModel(dayLog: updateDayLog!) :
            DayLogCellViewModel.newDayLog(state: .memo),
          presentAddMemo: $presentAddMemo
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
