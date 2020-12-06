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
    NavigationView() {
      IndexView()
        .navigationBarHidden(true)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
