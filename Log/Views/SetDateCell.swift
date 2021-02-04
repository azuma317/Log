//
//  SetDateCell.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI
import SwiftDate

struct SetDateCell: View {
  @State var isAllDay = true
  @State var date = Date()
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
            Button(action: {
              withAnimation {
                self.showDateScreen.toggle()
              }
            }, label: {
              Text(date.in(region: .current).toString(.date(.medium)))
                .foregroundColor(Color(.label))
            })

            Spacer()

            if !isAllDay {
              Button(action: {
                withAnimation {
                  self.showTimeScreen.toggle()
                }
              }, label: {
                Text(date.in(region: .current).toString(.time(.short)))
                  .foregroundColor(Color(.label))
              })
            }
          }
        }
        
      }

      if showDateScreen {
        DatePicker(
          "Start Date",
          selection: $date,
          displayedComponents: [.date]
        )
        .datePickerStyle(GraphicalDatePickerStyle())
        .transition(.opacity)
      }

      if showTimeScreen {
        DatePicker(
          "",
          selection: $date,
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
    SetDateCell()
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .light)

    SetDateCell()
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .dark)
  }
}
