//
//  IndexView.swift
//  Log
//
//  Created by AzumaSato on 2020/12/06.
//

import SwiftUI
import DynamicColor

struct IndexView: View {
  var body: some View {
    ZStack {
      Color(DynamicColor(hexString: "2D2D2D"))
        .edgesIgnoringSafeArea(.all)

      VStack {
        Text("Index")
          .font(.system(size: 48.0, weight: .bold))
          .foregroundColor(.white)
          .padding(.bottom)

        NavigationLink(destination: DairyLogView().navigationBarHidden(true)) {
          Text("Dairy Log")
            .font(.system(size: 20.0))
            .foregroundColor(.white)
            .padding(.all, 50)
        }

        NavigationLink(destination: DairyLogView().navigationBarHidden(true)) {
          Text("Monthly Log")
            .font(.system(size: 20.0))
            .foregroundColor(.white)
            .padding(.all, 50)
        }

        NavigationLink(destination: DairyLogView().navigationBarHidden(true)) {
          Text("Feture Log")
            .font(.system(size: 20.0))
            .foregroundColor(.white)
            .padding(.all, 50)
        }

        NavigationLink(destination: DairyLogView().navigationBarHidden(true)) {
          Text("Settings")
            .font(.system(size: 20.0))
            .foregroundColor(.white)
            .padding(.all, 50)
        }
      }
    }
  }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
