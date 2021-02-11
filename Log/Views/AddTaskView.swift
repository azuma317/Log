//
//  AddTaskView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct AddTaskView: View {
  var animation: Namespace.ID

  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  @Binding var presentAddTask: Bool

  @State var loadContent = false

  var body: some View {
    VStack {
      HStack {
        Button("Close") {
          withAnimation {
            presentAddTask.toggle()
          }
        }
        .padding()
        .foregroundColor(Color(.secondaryLabel))

        Spacer()

        Button("Save") {
          if dayLogCellVM.dayLog.id == nil {
            dayLogCellVM.dayLogRepository.addDayLog(dayLogCellVM.dayLog)
          } else {
            dayLogCellVM.dayLogRepository.updateDayLog(dayLogCellVM.dayLog)
          }
          withAnimation {
            presentAddTask.toggle()
          }
        }
        .padding()
        .foregroundColor(Color(.systemBlue))
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
    .background(Color(.systemBackground))
    .onAppear {
      withAnimation(Animation.spring().delay(0.45)) {
        loadContent.toggle()
      }
    }
  }
}

struct AddTaskView_Previews: PreviewProvider {
  @Namespace static var animation
  static var previews: some View {
    AddTaskView(
      animation: animation,
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[0]),
      presentAddTask: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .light)

    AddTaskView(
      animation: animation,
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[1]),
      presentAddTask: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .dark)
  }
}
