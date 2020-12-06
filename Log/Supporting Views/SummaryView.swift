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
    ZStack {
      Color(DynamicColor(hexString: "2D2D2D"))
        .edgesIgnoringSafeArea(.all)

      HStack {
        Spacer()

        Button(action: {}, label: {
          ZStack {
            Color(
              DynamicColor(hexString: "2D2D2D")
                .darkened(amount: 0.1)
            )

            VStack {
              Spacer()
              Text("13").font(.title)
              Text("All").padding(.vertical, 8)
            }
          }
        })
        .frame(width: 80, height: 100, alignment: .center)
        .foregroundColor(.white)

        Spacer()

        Button(action: {}, label: {
          ZStack {
            Color(
              DynamicColor(hexString: "2D2D2D")
                .lighter(amount: 0.1)
            )

            VStack {
              Spacer()
              Text("13").font(.title)
              Text("All").padding(.vertical, 8)
            }
          }
        })
        .frame(width: 80, height: 100, alignment: .center)
        .foregroundColor(.white)

        Spacer()

        Button(action: {}, label: {
          ZStack {
            Color(
              DynamicColor(hexString: "2D2D2D")
                .lighter(amount: 0.1)
            )

            VStack {
              Spacer()
              Text("13").font(.title)
              Text("All").padding(.vertical, 8)
            }
          }
        })
        .frame(width: 80, height: 100, alignment: .center)
        .foregroundColor(.white)

        Spacer()
      }
    }
    .frame(width: nil, height: 120, alignment: .center)
  }
}

struct SummaryView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryView()
  }
}
