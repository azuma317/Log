//
//  AddTaskView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct AddTaskView: View {
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

        SetDetailCell(text: $text)

        Divider()

        SetDateCell()

        Spacer()

        Divider()
      }
    }
    .background(Color(.systemBackground))
  }
}

struct AddTaskView_Previews: PreviewProvider {
  static var previews: some View {
    AddTaskView(text: .constant("New Task"))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .light)

    AddTaskView(text: .constant("New Task"))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .dark)
  }
}
