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
        Text("Hello, World!")
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
