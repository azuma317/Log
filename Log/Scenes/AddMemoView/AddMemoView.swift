//
//  AddMemoView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/11.
//

import SwiftUI

struct AddMemoView: View {
  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  @Binding var presentAddMemo: Bool

  @State var loadContent = false
  @State var saveIsEnabled = false

  var body: some View {
    VStack {
      AddLogHeader(presentToggle: $presentAddMemo, saveIsEnabled: $saveIsEnabled) {
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
      }
      .frame(height: loadContent ? nil : 0)
      .opacity(loadContent ? 1 : 0)

      Spacer(minLength: 0)
    }
    .onReceive(
      dayLogCellVM.$dayLog,
      perform: { dayLog in
        saveIsEnabled = dayLog.log.count > 0
      }
    )
    .background(Color(.systemBackground))
    .onAppear {
      withAnimation(Animation.spring().delay(0.45)) {
        loadContent.toggle()
      }
    }
  }
}

struct AddMemoView_Previews: PreviewProvider {
  static var previews: some View {
    AddMemoView(
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[0]),
      presentAddMemo: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .light)

    AddMemoView(
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[1]),
      presentAddMemo: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .dark)
  }
}
