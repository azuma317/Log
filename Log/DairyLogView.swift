//
//  DairyLogView.swift
//  Log
//
//  Created by AzumaSato on 2020/11/29.
//

import SwiftUI
import DynamicColor

struct DairyLogView: View {
  var body: some View {
    ZStack {
      Color(DynamicColor(hexString: "2D2D2D"))
        .edgesIgnoringSafeArea(.all)

      VStack {
        VStack {
          HStack {
            Spacer()

            Text("Dairy Log")
              .foregroundColor(
                Color(DynamicColor(hexString: "E84F88"))
              )
          }

          Spacer()
        }
      }
    }
  }
}

struct DairyLogView_Previews: PreviewProvider {
  static var previews: some View {
    DairyLogView()
  }
}
