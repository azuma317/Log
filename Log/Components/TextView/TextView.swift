//
//  TextView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct TextView: View {
  private let placeholder: String
  @Binding var text: String

  init(_ placeholder: String, text: Binding<String>) {
    self.placeholder = placeholder
    self._text = text
  }

  var body: some View {
    ZStack {
      TextEditor(text: $text)
        .background(
          HStack(alignment: .top) {
            text.allSatisfy({ $0.isWhitespace }) ? Text(placeholder) : Text("")
            Spacer()
          }
          .foregroundColor(Color.primary.opacity(0.25))
          .padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 0))
        )

      Text(text).opacity(0).padding(.all, 8)
    }
  }
}

struct TextView_Previews: PreviewProvider {
  static var previews: some View {
    TextView("Sample", text: .constant(""))
      .padding()
      .previewLayout(PreviewLayout.sizeThatFits)
  }
}
