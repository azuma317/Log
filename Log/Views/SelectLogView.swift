//
//  SelectLogView.swift
//  Log
//
//  Created by AzumaSato on 2021/02/13.
//

import SwiftUI

struct SelectLogView: View {
  @Binding var presentSelectLog: Bool

  var onSelect: (LogState) -> Void = { _ in }

  var body: some View {
    ZStack {
      Color(.black)
        .opacity(0.5)
        .frame(width: UIScreen.main.bounds.width)
        .ignoresSafeArea()
        .gesture(
          TapGesture(count: 1)
            .onEnded({ _ in
              withAnimation {
                self.presentSelectLog.toggle()
              }
            })
        )
        .gesture(
          DragGesture()
            .onEnded({ _ in
              withAnimation {
                self.presentSelectLog.toggle()
              }
            })
        )

      VStack {
        Spacer()

        HStack {
          ForEach(LogState.allCases, id: \.self) { state in
            Button(action: {
              self.presentSelectLog.toggle()
              self.onSelect(state)
            }, label: {
              VStack(alignment: .center) {
                Image(systemName: state.imageName)
                  .resizable()
                  .frame(width: 24.0, height: 24.0)
                  .padding()

                Text(state.description)
              }
              .foregroundColor(Color(.label))
            })
          }
          .padding()
          .background(Color(.systemBackground))
          .cornerRadius(10)
        }
        .padding()
        .background(Color(.tertiarySystemBackground))
        .cornerRadius(10)
        .padding()
      }
    }
  }
}

struct SelectLogView_Previews: PreviewProvider {
  static var previews: some View {
    SelectLogView(presentSelectLog: .constant(true))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .light)

    SelectLogView(presentSelectLog: .constant(true))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .dark)
  }
}
