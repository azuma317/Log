//
//  DairyLogRow.swift
//  Log
//
//  Created by AzumaSato on 2020/12/07.
//

import SwiftUI
import DynamicColor

struct DairyLogRow: View {
  var title: String

  var body: some View {
    HStack(spacing: 0) {
      Text("*")
        .font(.system(size: 24, weight: .bold, design: .default))
        .frame(width: 32, height: 40, alignment: .center)
      Text("*")
        .font(.system(size: 24, weight: .bold, design: .default))
        .frame(width: 32, height: 40, alignment: .center)
      VStack(alignment: .leading) {
        Text(title)
          .font(.system(size: 17, weight: .regular, design: .default))
        HStack(spacing: 8) {
          Text("Alarm:")
            .font(.system(size: 12, weight: .regular, design: .default))
          Text("2019.10.13 15:56")
            .font(.system(size: 12, weight: .regular, design: .default))
        }
      }
      Spacer()
    }
    .foregroundColor(.white)
  }
}

struct DairyLogRow_Previews: PreviewProvider {
  static var previews: some View {
    DairyLogRow(title: "Sample")
      .background(Color(DynamicColor(hexString: "2D2D2D")))
      .previewLayout(.fixed(width: 360, height: 48))
  }
}
