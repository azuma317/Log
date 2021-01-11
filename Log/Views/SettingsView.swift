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
        Image(systemName: "snow")
          .resizable()
          .frame(width: 80, height: 80)
          .aspectRatio(contentMode: .fit)
          .padding(.top, 20)

        Text("Thanks for using")
          .font(.title)

        Text("Zebra")
          .font(.title)
          .fontWeight(.semibold)

        Form {
          Section {
            HStack {
              Image(systemName: "checkmark.circle")
              Text("App Icon")
              Spacer()
              Text("Plain")
            }
          }
          .listRowBackground(Color(.secondarySystemBackground))

          Section {
            HStack {
              Image(systemName: "questionmark.circle")
              Text("Help & Feedback")
            }
            NavigationLink(destination: Text("About!")) {
              HStack {
                Image(systemName: "info.circle")
                Text("About")
              }
            }
          }
          .listRowBackground(Color(.secondarySystemBackground))

          AccountSection(settingsViewModel: self.settingsViewModel)
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }, label: {
          Text("Done")
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

struct AccountSection: View {
  @ObservedObject var settingsViewModel: SettingsViewModel
  @State private var showSignInView = false

  var body: some View {
    Section(footer: footer) {
      button
    }
    .listRowBackground(Color(.secondarySystemBackground))
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