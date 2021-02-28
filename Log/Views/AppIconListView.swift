//
//  AppIconListView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/26.
//

import SwiftUI

struct AppIconListView: View {
  @ObservedObject var appIconListViewModel = AppIconListViewModel()

  var body: some View {
    Text("Hello, World!")
  }
}

struct AppIconListView_Previews: PreviewProvider {
  static var previews: some View {
    AppIconListView()
  }
}
