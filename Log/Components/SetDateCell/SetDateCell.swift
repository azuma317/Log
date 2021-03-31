//
//  SetDateCell.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import FirebaseFirestore
import SwiftDate
import SwiftUI

struct SetDateCell: View {
  @Binding var timestamp: Timestamp

  @State var isAllDay = true
  @State var showDateScreen = false
  @State var showTimeScreen = false

  var body: some View {
    VStack {
      HStack(alignment: .top, spacing: 0) {
        Image(systemName: "clock")
          .frame(width: 16.0, height: 16.0)
          .padding(.vertical, 8.0)
          .padding(.trailing, 16.0)

        VStack {
          Toggle(isOn: self.$isAllDay) {
            Text("All Day")
              .font(.system(size: 18.0))
              .foregroundColor(Color(.label))
          }
          .toggleStyle(SwitchToggleStyle())

          HStack {
            Button(
              action: {
                withAnimation(.easeOut(duration: 0.2)) {
                  self.showDateScreen.toggle()
                  self.showTimeScreen = false
                }
              },
              label: {
                Text(timestamp.dateValue().in(region: .current).toString(.date(.medium)))
                  .foregroundColor(Color(.label))
              })

            Spacer()

            if !isAllDay {
              Button(
                action: {
                  withAnimation(.easeOut(duration: 0.2)) {
                    self.showTimeScreen.toggle()
                    self.showDateScreen = false
                  }
                },
                label: {
                  Text(timestamp.dateValue().in(region: .current).toString(.time(.short)))
                    .foregroundColor(Color(.label))
                })
            }
          }
        }

      }

      if showDateScreen {
        DatePicker(
          "Start Date",
          selection: Binding<Date>(
            get: { self.timestamp.dateValue() },
            set: { self.timestamp = Timestamp(date: $0) }
          ),
          displayedComponents: [.date]
        )
        .datePickerStyle(GraphicalDatePickerStyle())
        .transition(.opacity)
      }

      if showTimeScreen {
        DatePicker(
          "",
          selection: Binding<Date>(
            get: { self.timestamp.dateValue() },
            set: { self.timestamp = Timestamp(date: $0) }
          ),
          displayedComponents: [.hourAndMinute]
        )
        .datePickerStyle(WheelDatePickerStyle())
        .transition(.opacity)
      }
    }
    .padding(.horizontal)
    .background(Color(.systemBackground))
  }
}

struct SetDateCell_Previews: PreviewProvider {
  static var previews: some View {
    SetDateCell(timestamp: .constant(Timestamp(date: Date())))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .light)

    SetDateCell(timestamp: .constant(Timestamp(date: Date())))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .dark)
  }
}
