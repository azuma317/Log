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
        HeaderView(title: "Dairy Log")
        SummaryView()
        List {
          ForEach(0..<4) { (index: Int) in
            DairyLogRow(title: "Sample")
          }
          .listRowBackground(Color(DynamicColor(hexString: "2D2D2D")))
        }
        Spacer()
      }
    }
  }
}

struct DairyLogView_Previews: PreviewProvider {
  static var previews: some View {
    DairyLogView()
  }
}
