//
//  AddLogHeader.swift
//  Log
//
//  Created by AzumaSato on 2021/02/13.
//

import SwiftUI

struct AddLogHeader: View {

  @Binding var presentToggle: Bool

  var onSave: () -> Void = {}

  var body: some View {
    HStack {
      Button("Close") {
        withAnimation(.spring()) {
          presentToggle.toggle()
        }
      }
      .padding()
      .foregroundColor(Color(.secondaryLabel))

      Spacer()

      Button("Save") {
        withAnimation {
          presentToggle.toggle()
        }
        self.onSave()
      }
      .padding()
      .foregroundColor(Color(.systemBlue))
    }
  }
}

struct AddLogHeader_Previews: PreviewProvider {
  static var previews: some View {
    AddLogHeader(presentToggle: .constant(false))
      .previewLayout(PreviewLayout.sizeThatFits)
  }
}
