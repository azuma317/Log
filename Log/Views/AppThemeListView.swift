//
//  AppThemeListView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/26.
//

import SwiftUI

struct AppThemeListView: View {
  @ObservedObject var appThemeListViewModel = AppThemeListViewModel()

  var body: some View {
    Form {
      Section {
        ForEach(AppTheme.allCases, id: \.self) { theme in
          HStack {
            Text(theme.description)
            if appThemeListViewModel.selectedTheme == theme {
              Spacer()
              Image(systemName: "checkmark")
            }
          }
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
