//
//  TextView.swift
//  Log
//
//  Created by AzumaSato on 2021/01/30.
//

import SwiftUI

struct TextView: UIViewRepresentable {
  @Binding var text: String

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.delegate = context.coordinator
    textView.isScrollEnabled = false
    textView.isEditable = true
    textView.isUserInteractionEnabled = true
    return textView
  }

  func updateUIView(_ textView: UITextView, context: Context) {
    textView.text = text
  }
}

extension TextView {
  final class Coordinator: NSObject, UITextViewDelegate {
    private var textView: TextView

    init(_ textView: TextView) {
      self.textView = textView
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      return true
    }

    func textViewDidChange(_ textView: UITextView) {
      self.textView.text = textView.text
    }
  }
}

struct TextView_Previews: PreviewProvider {
  static var previews: some View {
    TextView(text: .constant("Sample"))
      .padding()
      .previewLayout(PreviewLayout.sizeThatFits)
  }
}
