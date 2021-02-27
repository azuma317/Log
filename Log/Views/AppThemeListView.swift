//
//  AppThemeListView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/26.
//

import SwiftUI

struct AppThemeListView: View {
  var body: some View {
    Form {
      Section {
        ForEach(AppTheme.allCases, id: \.self) { theme in
          Text(theme.description)
        }
      }
    }
    .navigationBarTitle("AppTheme", displayMode: .inline)
  }
}

struct AppThemeListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      AppThemeListView()
        .environment(\.colorScheme, .light)

      AppThemeListView()
        .environment(\.colorScheme, .dark)
    }
  }
}
