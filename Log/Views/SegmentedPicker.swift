//
//  SegmentedPicker.swift
//  Log
//
//  Created by AzumaSato on 2021/01/07.
//

import SwiftUI

extension View {
  func eraseToAnyView() -> AnyView {
    AnyView(self)
  }
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

struct BackgroundGeometryReader: View {
  var body: some View {
    GeometryReader { geometry in
      return Color
        .clear
        .preference(key: SizePreferenceKey.self, value: geometry.size)
    }
  }
}

struct SizeAwareViewModifier: ViewModifier {
  @Binding private var viewSize: CGSize

  init(viewSize: Binding<CGSize>) {
    self._viewSize = viewSize
  }

  func body(content: Content) -> some View {
    content
      .background(BackgroundGeometryReader())
      .onPreferenceChange(SizePreferenceKey.self, perform: { value in
        if self.viewSize != value {
          self.viewSize = value
        }
      })
  }
}

struct SegmentedPicker: View {
  private static let ActiveSegmentColor: Color = Color(.tertiarySystemBackground)
  private static let BackgroundColor: Color = Color(.secondarySystemBackground)
  private static let ShadowColor: Color = Color.black.opacity(0.2)
  private static let TextColor: Color = Color(.secondaryLabel)
  private static let SelectedTextColor: Color = Color(.label)
  private static let TextFont: Font = Font.system(size: 12.0)
  private static let SegmentCornerRadius: CGFloat = 18.0
  private static let ShadowRadius: CGFloat = 4.0
  private static let SegmentXPadding: CGFloat = 16.0
  private static let SegmentYPadding: CGFloat = 8.0
  private static let PickerPadding: CGFloat = 4.0
  private static let AnimationDuration: Double = 0.1

  private let items: [String]

  @Binding private var selection: Int

  @State private var segmentSize: CGSize = .zero

  private var activeSegmentView: AnyView {
    let isInitialized: Bool = segmentSize != .zero
    if !isInitialized {
      return EmptyView().eraseToAnyView()
    }

    return RoundedRectangle(cornerRadius: SegmentedPicker.SegmentCornerRadius)
      .foregroundColor(SegmentedPicker.ActiveSegmentColor)
      .shadow(color: SegmentedPicker.ShadowColor, radius: SegmentedPicker.ShadowRadius)
      .frame(width: self.segmentSize.width, height: self.segmentSize.height)
      .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
      .animation(Animation.linear(duration: SegmentedPicker.AnimationDuration))
      .eraseToAnyView()
  }

  init(items: [String], selection: Binding<Int>) {
    self.items = items
    self._selection = selection
  }

  var body: some View {
    ZStack(alignment: .leading) {
      self.activeSegmentView

      HStack {
        ForEach(0..<self.items.count, id: \.self) { index in
          self.getSegmentView(for: index)
        }
      }
    }
    .padding(SegmentedPicker.PickerPadding)
    .background(SegmentedPicker.BackgroundColor)
    .clipShape(
      RoundedRectangle(cornerRadius: SegmentedPicker.SegmentCornerRadius)
    )
  }

  private func computeActiveSegmentHorizontalOffset() -> CGFloat {
    CGFloat(self.selection) * (self.segmentSize.width + SegmentedPicker.SegmentXPadding / 2)
  }

  private func getSegmentView(for index: Int) -> some View {
    guard index < self.items.count else {
      return EmptyView().eraseToAnyView()
    }
    let isSelected = self.selection == index

    return Text(self.items[index])
      .foregroundColor(
        isSelected
          ? SegmentedPicker.SelectedTextColor
          : SegmentedPicker.TextColor
      )
      .lineLimit(1)
      .padding(.vertical, SegmentedPicker.SegmentYPadding)
      .padding(.horizontal, SegmentedPicker.SegmentXPadding)
      .frame(minWidth: 0, maxWidth: .infinity)
      .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
      .onTapGesture { self.onItemTap(index: index) }
      .eraseToAnyView()
  }

  private func onItemTap(index: Int) {
    guard index < self.items.count else { return }
    self.selection = index
  }

}

struct SegmentedPicker_Previews: PreviewProvider {
  static var previews: some View {
    SegmentedPicker(items: ["M", "T", "W", "T", "F"], selection: .constant(2))
      .padding()
      .previewLayout(PreviewLayout.sizeThatFits)
  }
}
