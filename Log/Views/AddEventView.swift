//
//  AddEventView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/04.
//

import SwiftUI

struct AddEventView: View {
  var animation: Namespace.ID

  @ObservedObject var dayLogCellVM: DayLogCellViewModel
  @Binding var presentAddEvent: Bool

  @State var loadContent = false

  var body: some View {
    VStack {
      HStack {
        Button("Close") {
          withAnimation(.spring()) {
            presentAddEvent.toggle()
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
            presentAddEvent.toggle()
          }
        }
        .padding()
        .foregroundColor(Color(.systemBlue))
      }

      TextField("Title", text: $dayLogCellVM.dayLog.log)
        .font(.title)
        .padding()
        .padding(.leading, 32.0)
        .matchedGeometryEffect(id: "title", in: animation)

      ScrollView {
        Divider()

        SetDateCell()
          .padding(.vertical)

        SetNotificationCell()
          .padding(.bottom)

        Divider()

        SetDetailCell(text: $dayLogCellVM.dayLog.description)

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

struct AddEventView_Previews: PreviewProvider {
  @Namespace static var animation
  static var previews: some View {
    AddEventView(
      animation: animation,
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[0]),
      presentAddEvent: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .light)

    AddEventView(
      animation: animation,
      dayLogCellVM: DayLogCellViewModel(dayLog: testDayLogs[1]),
      presentAddEvent: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .dark)
  }
}
