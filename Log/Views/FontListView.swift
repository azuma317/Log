//
//  FontListView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/28.
//

import SwiftUI

struct FontListView: View {
  @ObservedObject var fontListViewModel = FontListViewModel()

  var body: some View {
    Text("Hello, World!")
  }
}

struct FontListView_Previews: PreviewProvider {
  static var previews: some View {
    FontListView()
  }
}
