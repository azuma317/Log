//
//  HeaderView.swift
//  Log
//
//  Created by AzumaSato on 2020/12/07.
//

import SwiftUI
import DynamicColor

struct HeaderView: View {
  var title: String

  var body: some View {
    HStack {
      Spacer()

      Text("Dairy Log")
        .foregroundColor(
          Color(DynamicColor(hexString: "E84F88"))
        )
        .padding(.horizontal)
    }
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HeaderView(title: "Dairy Log")
      .previewLayout(.fixed(width: 360, height: 24))
  }
}
