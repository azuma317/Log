//
//  AddTaskView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct AddTaskView: View {
  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  @Binding var presentAddTask: Bool

  @State var loadContent = false
  @State var saveIsEnabled = false

  var body: some View {
    VStack {
      AddLogHeader(presentToggle: $presentAddTask, saveIsEnabled: $saveIsEnabled) {
        if dayLogCellVM.dayLog.id == nil {
          dayLogCellVM.dayLogRepository.addDayLog(dayLogCellVM.dayLog)
        } else {
          dayLogCellVM.dayLogRepository.updateDayLog(dayLogCellVM.dayLog)
        }
      }

      TextField("Title", text: $dayLogCellVM.dayLog.log)
        .font(.title)
        .padding()
        .padding(.leading, 32.0)

      ScrollView {
        Divider()

        SetDetailCell(text: $dayLogCellVM.dayLog.description)

        Divider()

        SetDateCell()
          .padding(.vertical)

        SetNotificationCell()
          .padding(.bottom)

        Divider()
      }
      .frame(height: loadContent ? nil : 0)
      .opacity(loadContent ? 1 : 0)

      Spacer(minLength: 0)
    }
    .onReceive(dayLogCellVM.$dayLog, perform: { dayLog in
      saveIsEnabled = dayLog.log.count > 0
    })
    .background(Color(.systemBackground))
    .onAppear {
      withAnimation(Animation.spring().delay(0.45)) {
        loadContent.toggle()
      }
    }
  }
}

struct AddTaskView_Previews: PreviewProvider {
  static var previews: some View {
    AddTaskView(
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[0]),
      presentAddTask: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .light)

    AddTaskView(
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[1]),
      presentAddTask: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .dark)
  }
}
