//
//  SetDetailCell.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct SetDetailCell: View {
  @Binding var text: String

  var body: some View {
    HStack(alignment: .top) {
      Image(systemName: "text.justifyleft")
        .frame(width: 16.0, height: 16.0)
        .padding(8.0)

      TextView(text: $text)
    }
  }
}

struct SetDetailCell_Previews: PreviewProvider {
  static var previews: some View {
    SetDetailCell(text: .constant(""))
      .padding()
      .previewLayout(PreviewLayout.sizeThatFits)
  }
}
