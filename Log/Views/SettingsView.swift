//
//  SettingsView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/03.
//

import SwiftUI

struct SettingsView: View {
  @ObservedObject var settingsViewModel = SettingsViewModel()
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  var body: some View {
    NavigationView {
      VStack {
        Form {
          AppearanceSection()

          CustomFormatSection()

          AccountSection(settingsViewModel: self.settingsViewModel)
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }, label: {
          Text("Done")
            .foregroundColor(Color(.systemBlue))
        }))
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SettingsView()
        .environment(\.colorScheme, .light)

      SettingsView()
        .environment(\.colorScheme, .dark)
    }
  }
}

struct AppearanceSection: View {

  var body: some View {
    Section {
      HStack {
        Image(systemName: "checkmark.circle")
        Text("Appearance")
      }
      HStack {
        Image(systemName: "checkmark.circle")
        Text("App Icon")
      }
    }
  }
}

struct CustomFormatSection: View {

  @State var dateFormat: DateFormat = .month_day
  @State var timeFormat: TimeFormat = .time_meridiem

  var body: some View {
    Section {
      HStack {
        Image(systemName: "checkmark.circle")
        Text("Date Format")
        Spacer()
        Text(Date().in(region: .current).toString(.custom(dateFormat.format)))
      }
      .onTapGesture {
        dateFormat = DateFormat(rawValue: dateFormat.rawValue + 1) ?? .month_day
      }
      HStack {
        Image(systemName: "checkmark.circle")
        Text("Time Format")
        Spacer()
        Text(Date().in(region: .current).toString(.custom(timeFormat.format)))
      }
      .onTapGesture {
        timeFormat = TimeFormat(rawValue: timeFormat.rawValue + 1) ?? .time_meridiem
      }
    }
  }
}

struct AccountSection: View {
  @ObservedObject var settingsViewModel: SettingsViewModel
  @State private var showSignInView = false

  var body: some View {
    Section(footer: footer) {
      button
    }
  }

  var footer: some View {
    HStack {
      Spacer()
      if settingsViewModel.isAnonymous {
        Text("You're not logged in.")
      } else {
        VStack {
          Text("Thanks for using Zebra, \(self.settingsViewModel.displayName)!")
          Text("Logged in as \(self.settingsViewModel.email)")
        }
      }
      Spacer()
    }
  }

  var button: some View {
    VStack {
      if settingsViewModel.isAnonymous {
        Button(action: { self.login() }, label: {
          HStack {
            Spacer()
            Text("Login")
            Spacer()
          }
        })
      } else {
        Button(action: { self.logout() }, label: {
          HStack {
            Spacer()
            Text("Logout")
            Spacer()
          }
        })
      }
    }
    .sheet(isPresented: self.$showSignInView, content: {
      SignInView()
    })
  }

  func login() {
    self.showSignInView.toggle()
  }

  func logout() {
    self.settingsViewModel.logout()
  }
}
