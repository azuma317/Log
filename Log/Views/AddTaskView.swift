//
//  AddTaskView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct AddTaskView: View {
  @Binding var text: String

  var body: some View {
    NavigationView {
      ScrollView {
        SetDetailCell(text: $text)
          .padding(.horizontal)

        Divider()

        SetDateCell()
          .padding(.horizontal)

        Spacer()

        Divider()
      }
    }
  }
}

struct AddTaskView_Previews: PreviewProvider {
  static var previews: some View {
    AddTaskView(text: .constant("Sample"))
  }
}
