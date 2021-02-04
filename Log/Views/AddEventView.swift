//
//  AddEventView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/04.
//

import SwiftUI

struct AddEventView: View {
  @Binding var text: String

  var body: some View {
    VStack {
      HStack {
        Button("Close") {
          print("Close")
        }
        .padding()
        .foregroundColor(Color(.secondaryLabel))

        Spacer()

        Button("Save") {
          print("Save")
        }
        .padding()
        .foregroundColor(Color(.systemBlue))
      }

      TextField("Title", text: $text)
        .font(.title)
        .padding()
        .padding(.leading, 32.0)

      ScrollView {
        Divider()

        SetDateCell()
          .padding(.vertical)

        Divider()

        SetNotificationCell()
          .padding(.vertical)

        Divider()

        SetDetailCell(text: $text)
          .padding(.vertical)

        Divider()
      }
    }
    .background(Color(.systemBackground))
  }
}

struct AddEventView_Previews: PreviewProvider {
  static var previews: some View {
    AddEventView(text: .constant("New Event"))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .light)

    AddEventView(text: .constant("New Event"))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .dark)
  }
}
