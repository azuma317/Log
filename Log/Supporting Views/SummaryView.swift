//
//  SummaryView.swift
//  Log
//
//  Created by AzumaSato on 2020/11/30.
//

import SwiftUI
import DynamicColor

struct SummaryView: View {
  var body: some View {
    HStack(alignment: .center) {
      Spacer()

      Button(action: {}, label: {
        VStack {
          Text("18")
            .font(.system(size: 24, weight: .bold, design: .default))
          Text("Task")
            .font(.system(size: 16, weight: .medium, design: .default))
            .padding(.vertical, 8)
        }
      })
      .foregroundColor(.white)

      Spacer()

      Button(action: {}, label: {
        VStack {
          Text("13")
            .font(.system(size: 24, weight: .bold, design: .default))
          Text("Event")
            .font(.system(size: 16, weight: .medium, design: .default))
            .padding(.vertical, 8)
        }
      })
      .foregroundColor(.white)

      Spacer()

      Button(action: {}, label: {
        VStack {
          Text("5")
            .font(.system(size: 24, weight: .bold, design: .default))
          Text("Memo")
            .font(.system(size: 16, weight: .medium, design: .default))
            .padding(.vertical, 8)
        }
      })
      .foregroundColor(.white)

      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .padding(.all, 16)
    .background(Color(DynamicColor(hexString: "2D2D2D")))
    .modifier(CardModifier())
    .padding(.all, 16)
  }
}

struct SummaryView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryView()
      .previewLayout(.fixed(width: 360, height: 150))
  }
}
