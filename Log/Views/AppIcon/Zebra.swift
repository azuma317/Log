//
//  Zebra.swift
//  Log
//
//  Created by AzumaSato on 2021/01/04.
//

import SwiftUI

struct Zebra: View {
  var body: some View {
    Text("Zebra")
      .font(.custom("Marker Felt", size: 32.0))
      .fontWeight(.bold)
  }
}

struct Zebra_Previews: PreviewProvider {
  static var previews: some View {
    Zebra()
  }
}
