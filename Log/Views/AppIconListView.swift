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
    Form {
      Section {
        ForEach(AppIcon.allCases, id: \.self) { appIcon in
          HStack {
            Text(appIcon.description)
            if appIconListViewModel.selectedIcon == appIcon {
              Spacer()
              Image(systemName: "checkmark")
            }
          }
          .onTapGesture {
            appIconListViewModel.selectedIcon = appIcon
          }
        }
      }
    }
  }
}

struct AppIconListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      AppIconListView()
        .environment(\.colorScheme, .light)

      AppIconListView()
        .environment(\.colorScheme, .dark)
    }
  }
}
