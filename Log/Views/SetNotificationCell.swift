//
//  SetRepeatCell.swift
//  Log
//
//  Created by AzumaSato on 2021/02/04.
//

import SwiftUI

struct SetRepeatCell: View {
  var body: some View {
    HStack(spacing: 0) {
      Image(systemName: "arrow.clockwise")
        .frame(width: 16.0, height: 16.0)
        .padding(.vertical, 8.0)
        .padding(.trailing, 16.0)

      Text("Sample")

      Spacer()
    }
    .padding(.horizontal)
    .background(Color(.systemBackground))
  }
}

struct SetRepeatCell_Previews: PreviewProvider {
  static var previews: some View {
    SetRepeatCell()
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .light)

    SetRepeatCell()
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .dark)
  }
}
