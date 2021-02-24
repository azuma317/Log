//
//  AddLogHeader.swift
//  Log
//
//  Created by AzumaSato on 2021/02/13.
//

import SwiftUI

struct AddLogHeader: View {

  @Binding var presentToggle: Bool
  @Binding var saveIsEnabled: Bool

  var onSave: () -> Void = {}

  var body: some View {
    HStack {
      Button("Close") {
        withAnimation(.easeInOut) {
          presentToggle.toggle()
        }
      }
      .padding()
      .foregroundColor(Color(.secondaryLabel))

      Spacer()

      Button("Save") {
        if saveIsEnabled {
          withAnimation {
            presentToggle.toggle()
          }
          self.onSave()
        }
      }
      .foregroundColor(saveIsEnabled ? Color.blue : Color(.secondaryLabel))
      .padding()
      .foregroundColor(Color(.systemBlue))
    }
  }
}

struct AddLogHeader_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      AddLogHeader(presentToggle: .constant(false), saveIsEnabled: .constant(true))
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .light)

      AddLogHeader(presentToggle: .constant(false), saveIsEnabled: .constant(false))
        .background(Color(.systemBackground))
        .previewLayout(PreviewLayout.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
  }
}
