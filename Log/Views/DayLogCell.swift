//
//  DayLogCell.swift
//  Log
//
//  Created by AzumaSato on 2021/02/09.
//

import SwiftUI

struct DayLogCell: View {
  var animation: Namespace.ID

  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  @GestureState var isDragging = false

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    HStack {
      if dayLogCellVM.subLogStateIconName != "" {
        Image(systemName: dayLogCellVM.subLogStateIconName)
          .frame(width: 20, height: 20)
      } else {
        Image(systemName: dayLogCellVM.logStateIconName)
          .frame(width: 20, height: 20)
      }

      Divider()

      TextField("Enter title", text: $dayLogCellVM.dayLog.log)
        .id(dayLogCellVM.dayLog.id)
        .matchedGeometryEffect(id: "text_\(dayLogCellVM.dayLog.id ?? "")", in: animation)
    }
    .padding()
    .background(Color(.secondarySystemBackground))
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 4)
    .shadow(color: Color.black.opacity(0.2), radius: 4, x: -4, y: -4)
    .offset(x: dayLogCellVM.offset)
    .gesture(
      DragGesture()
        .updating($isDragging, body: { (value, state, _) in
          state = true
          onChanged(value: value, viewModel: dayLogCellVM)
        })
        .onEnded({ value in
          onEnded(value: value, viewModel: dayLogCellVM)
        })
    )
    .contextMenu(menuItems: {
      Button(action: {
        onEdit(dayLogCellVM.dayLog)
      }, label: {
          Text("Update Item")
      })
    })
  }

  private func onChanged(value: DragGesture.Value, viewModel: DayLogCellViewModel) {
    if value.translation.width < 0 && isDragging {
      if value.translation.width > -64 {
        viewModel.offset = value.translation.width
      } else {
        viewModel.offset = -64 - (log(-63-value.translation.width) * 4)
      }
    }
  }

  private func onEnded(value: DragGesture.Value, viewModel: DayLogCellViewModel) {
    withAnimation {
      if value.translation.width <= -56 {
        viewModel.offset = -64
      } else {
        viewModel.offset = 0
      }
    }
  }
}


struct DayLogCell_Previews: PreviewProvider {
  @Namespace static var animation
  static var previews: some View {
    Group {
      DayLogListView(animation: animation)
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      DayLogListView(animation: animation)
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
