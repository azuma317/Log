//
//  ContentView.swift
//  Log
//
//  Created by AzumaSato on 2020/11/29.
//

import SwiftUI
import DynamicColor

struct ContentView: View {
  var body: some View {
    ZStack {
      Color(DynamicColor(hexString: "2D2D2D"))
        .edgesIgnoringSafeArea(.all)

      VStack {
        Text("Index")
          .font(.system(size: 48.0, weight: .bold))
          .foregroundColor(.white)

          .padding(.bottom)

        Button(action: {}, label: {
          Text("Dairy Log")
            .font(.system(size: 20.0, weight: .regular))
            .foregroundColor(.white)
        })
        .padding(.all, 50)

        Button(action: {}, label: {
          Text("Monthly Log")
            .font(.system(size: 20.0, weight: .regular))
            .foregroundColor(.white)
        })
        .padding(.all, 50)

        Button(action: {}, label: {
          Text("Future Log")
            .font(.system(size: 20.0, weight: .regular))
            .foregroundColor(.white)
        })
        .padding(.all, 50)

        Button(action: {}, label: {
          Text("Settings")
            .font(.system(size: 20.0, weight: .regular))
            .foregroundColor(.white)
        })
        .padding(.all, 50)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
