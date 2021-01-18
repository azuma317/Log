//
//  LogListView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/18.
//

import SwiftUI
import FirebaseFirestore
import SwiftDate

struct LogListView: View {

  @State var presentAddNewItem = false
  @State var showSettingsScreen = false
  @State var showBottomItems = true
  @State var selectedIndex = 0

  private let pickerItems = ["Day", "Monthly", "Future"]

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text(Date().in(region: .current).toString(.date(.medium)))
          .fontWeight(.semibold)
          .padding([.leading, .bottom])

        ZStack {
          switch pickerItems[selectedIndex] {
          case "Day":
            DayLogListView(presentAddNewItem: $presentAddNewItem)
          case "Monthly":
            EmptyView()
          case "Future":
            EmptyView()
          default:
            EmptyView()
          }

          VStack {
            Spacer()

            HStack {
              Spacer()

              Button(action: { self.presentAddNewItem.toggle() }, label: {
                HStack {
                  Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 48.0, height: 48.0)
                    .background(Color(.secondarySystemBackground))
                }
              })
              .accentColor(Color(UIColor.systemRed))
              .cornerRadius(24.0)
              .sheet(isPresented: self.$presentAddNewItem, content: {
                SettingsView()
              })
            }
          }
          .padding(.init(top: 0, leading: 0, bottom: 8.0, trailing: 16.0))
        }

        if showBottomItems {
          SegmentedPicker(items: pickerItems, selection: $selectedIndex)
            .padding(.horizontal)
        }
      }
      .navigationBarItems(trailing:
        Button(action: {
          self.showSettingsScreen.toggle()
        }, label: {
          Image(systemName: "gear")
        })
      )
      .navigationBarTitle(pickerItems[selectedIndex] + "Log")
      .sheet(isPresented: $showSettingsScreen, content: {
        SettingsView()
      })
      .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { _ in
        self.showBottomItems.toggle()
      })
      .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification), perform: { _ in
        self.showBottomItems.toggle()
      })
    }
  }
}

struct LogListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LogListView()
        .environment(\.colorScheme, .light)

      LogListView()
        .environment(\.colorScheme, .dark)
    }
  }
}

enum InputError: Error {
  case empty
}
