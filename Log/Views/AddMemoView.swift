//
//  AddMemoView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/11.
//

import SwiftUI

struct AddMemoView: View {
  var animation: Namespace.ID

  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  @Binding var presentAddMemo: Bool

  @State var loadContent = false

  var body: some View {
    VStack {
      AddLogHeader(presentToggle: $presentAddMemo) {
        if dayLogCellVM.dayLog.id == nil {
          dayLogCellVM.dayLogRepository.addDayLog(dayLogCellVM.dayLog)
        } else {
          dayLogCellVM.dayLogRepository.updateDayLog(dayLogCellVM.dayLog)
        }
      }
    }
    .background(Color(.systemBackground))
  }
}

struct AddMemoView_Previews: PreviewProvider {
  @Namespace static var animation
  static var previews: some View {
    AddMemoView(
      animation: animation,
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[1]),
      presentAddMemo: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .light)

    AddMemoView(
      animation: animation,
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[1]),
      presentAddMemo: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .dark)
  }
}
