//
//  AddEventView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/04.
//

import SwiftUI

struct AddEventView: View {
  @Binding var text: String
  @Binding var description: String
  @Binding var presentAddEvent: Bool

  @State var loadContent = false
  var animation: Namespace.ID

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
          print("Save")
        }
        .padding()
        .foregroundColor(Color(.systemBlue))
      }

      TextField("Title", text: $text)
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

        SetDetailCell(text: $description)

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
      text: .constant("New Event"),
      description: .constant("Add description"),
      presentAddEvent: .constant(true), animation: animation
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .light)

    AddEventView(
      text: .constant("New Event"),
      description: .constant("Add description"),
      presentAddEvent: .constant(true), animation: animation
    )
    .previewLayout(PreviewLayout.sizeThatFits)
    .environment(\.colorScheme, .dark)
  }
}
