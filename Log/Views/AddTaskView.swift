//
//  AddTaskView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct AddTaskView: View {
  @Binding var text: String
  @Binding var description: String
  @Binding var presentAddTask: Bool

  @State var loadContent = false

  var body: some View {
    VStack {
      HStack {
        Button("Close") {
          withAnimation(.spring()) {
            presentAddTask.toggle()
          }
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

        SetDetailCell(text: $description)

        Divider()

        SetDateCell()
          .padding(.vertical)

        SetNotificationCell()
          .padding(.bottom)

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

struct AddTaskView_Previews: PreviewProvider {
  static var previews: some View {
    AddTaskView(
      text: .constant("New Task"),
      description: .constant("Add description"),
      presentAddTask: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .light)

    AddTaskView(
      text: .constant("New Task"),
      description: .constant("Add description"),
      presentAddTask: .constant(true)
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .dark)
  }
}
