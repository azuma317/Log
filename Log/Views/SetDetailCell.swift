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
    HStack(alignment: .top, spacing: 0) {
      Image(systemName: "text.justifyleft")
        .frame(width: 16.0, height: 16.0)
        .padding(.vertical, 12.0)
        .padding(.trailing, 16.0)

      TextView(text: $text)
    }
    .padding(.horizontal)
  }
}

struct SetDetailCell_Previews: PreviewProvider {
  static var previews: some View {
    SetDetailCell(text: .constant("Sample"))
      .previewLayout(PreviewLayout.sizeThatFits)
  }
}
