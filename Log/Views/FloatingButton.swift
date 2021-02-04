//
//  FloatingButton.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct FloatingButton: View {
  var onSelect: (LogState) -> Void = { _ in }

  @State var showButtons: Bool = false

  var body: some View {
    ZStack {
      if showButtons {
        Color(.systemBackground)
          .opacity(0.5)
          .gesture(
            TapGesture(count: 1)
              .onEnded({ _ in
                withAnimation {
                  self.showButtons.toggle()
                }
              })
          )
          .gesture(
            DragGesture()
              .onEnded({ _ in
                withAnimation {
                  self.showButtons.toggle()
                }
              })
          )
      }

      HStack {
        Spacer()

        VStack {
          Spacer()

          if showButtons {
            ForEach(LogState.allCases, id: \.self) { state in
              Button(action: {
                self.showButtons.toggle()
                onSelect(state)
              }, label: {
                HStack {
                  Image(systemName: state.imageName)
                    .resizable()
                    .frame(width: 36.0, height: 36.0)
                    .background(Color(.secondarySystemBackground))
                }
              })
              .accentColor(Color(UIColor.systemRed))
              .cornerRadius(18.0)
              .transition(.move(edge: .bottom))
            }
          }

          Button(action: {
            withAnimation {
              self.showButtons.toggle()
            }
          }, label: {
            HStack {
              Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 56.0, height: 56.0)
                .background(Color(.secondarySystemBackground))
            }
          })
          .accentColor(Color(UIColor.systemRed))
          .cornerRadius(28.0)
        }
      }
      .padding(.init(top: 0, leading: 0, bottom: 8.0, trailing: 16.0))
    }
  }
}

struct FloatingButton_Previews: PreviewProvider {
  static var previews: some View {
    FloatingButton()
  }
}
