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
  @State var isTapping = false
  @GestureState var isDragging = false

  var onEdit: (DayLog) -> Void = { _ in }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if dayLogCellVM.subLogStateIconName != "" {
          Image(systemName: dayLogCellVM.subLogStateIconName)
            .frame(width: 20, height: 20)
        } else {
          Image(systemName: dayLogCellVM.logStateIconName)
            .frame(width: 20, height: 20)
        }

        Divider()

        Text(dayLogCellVM.dayLog.log)
          .font(.headline)
          .id(dayLogCellVM.dayLog.id)

        Spacer()

        if dayLogCellVM.dayLog.description != "" {
          if isTapping {
            Image(systemName: "chevron.up")
              .frame(width: 20, height: 20)
          } else {
            Image(systemName: "chevron.down")
              .frame(width: 20, height: 20)
          }
        }
      }

      if isTapping && dayLogCellVM.dayLog.description != "" {
        Text(dayLogCellVM.dayLog.description)
          .lineLimit(nil)
          .font(.subheadline)
          .fixedSize(horizontal: false, vertical: true)
          .padding(.top)
      }
    }
    .padding()
    .background(Color(.secondarySystemBackground))
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 4)
    .shadow(color: Color.black.opacity(0.2), radius: 4, x: -4, y: -4)
    .onTapGesture {
      withAnimation {
        self.isTapping.toggle()
      }
    }
    .contextMenu(menuItems: {
      Button(action: {
        onEdit(dayLogCellVM.dayLog)
      }, label: {
        Text("Edit")
        Image(systemName: "pencil")
      })

      Button(action: {
        dayLogCellVM.dayLogRepository.removeDayLog(dayLogCellVM.dayLog)
      }, label: {
        Text("Delete")
        Image(systemName: "trash")
      })
    })
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
