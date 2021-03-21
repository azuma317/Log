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
      .onPreferenceChange(
        SizePreferenceKey.self,
        perform: { value in
          if self.viewSize != value {
            self.viewSize = value
          }
        })
  }
}

struct SegmentedPicker: View {
  private static let activeSegmentColor: Color = Color(.tertiarySystemBackground)
  private static let backgroundColor: Color = Color(.secondarySystemBackground)
  private static let shadowColor: Color = Color.black.opacity(0.2)
  private static let textColor: Color = Color(.secondaryLabel)
  private static let selectedTextColor: Color = Color(.label)
  private static let textFont: Font = Font.system(size: 12.0)
  private static let segmentCornerRadius: CGFloat = 18.0
  private static let shadowRadius: CGFloat = 4.0
  private static let segmentXPadding: CGFloat = 16.0
  private static let segmentYPadding: CGFloat = 8.0
  private static let pickerPadding: CGFloat = 4.0
  private static let animationDuration: Double = 0.1

  private let items: [String]

  @Binding private var selection: Int

  @State private var segmentSize: CGSize = .zero

  private var activeSegmentView: AnyView {
    let isInitialized: Bool = segmentSize != .zero
    if !isInitialized {
      return EmptyView().eraseToAnyView()
    }

    return RoundedRectangle(cornerRadius: SegmentedPicker.segmentCornerRadius)
      .foregroundColor(SegmentedPicker.activeSegmentColor)
      .shadow(color: SegmentedPicker.shadowColor, radius: SegmentedPicker.shadowRadius)
      .frame(width: self.segmentSize.width, height: self.segmentSize.height)
      .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
      .animation(Animation.linear(duration: SegmentedPicker.animationDuration))
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
    .padding(SegmentedPicker.pickerPadding)
    .background(SegmentedPicker.backgroundColor)
    .clipShape(
      RoundedRectangle(cornerRadius: SegmentedPicker.segmentCornerRadius)
    )
    .padding(.horizontal)
  }

  private func computeActiveSegmentHorizontalOffset() -> CGFloat {
    CGFloat(self.selection) * (self.segmentSize.width + SegmentedPicker.segmentXPadding / 2)
  }

  private func getSegmentView(for index: Int) -> some View {
    guard index < self.items.count else {
      return EmptyView().eraseToAnyView()
    }
    let isSelected = self.selection == index

    return VStack {
      Text(self.items[index])
        .foregroundColor(
          isSelected
            ? SegmentedPicker.selectedTextColor
            : SegmentedPicker.textColor
        )
        .lineLimit(1)
        .padding(.vertical, SegmentedPicker.segmentYPadding)
        .padding(.horizontal, SegmentedPicker.segmentXPadding)
        .frame(minWidth: 0, maxWidth: .infinity)
        .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
    }
    .contentShape(Rectangle())
    .onTapGesture { self.onItemTap(index: index) }
    .eraseToAnyView()
  }

  private func onItemTap(index: Int) {
    guard index < self.items.count else { return }
    withAnimation(.easeInOut) {
      self.selection = index
    }
  }

}

struct SegmentedPicker_Previews: PreviewProvider {
  static var previews: some View {
    SegmentedPicker(items: ["M", "T", "W", "T", "F"], selection: .constant(2))
      .padding(.vertical)
      .background(Color(.systemBackground))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .light)

    SegmentedPicker(items: ["M", "T", "W", "T", "F"], selection: .constant(2))
      .padding(.vertical)
      .background(Color(.systemBackground))
      .previewLayout(PreviewLayout.sizeThatFits)
      .environment(\.colorScheme, .dark)
  }
}
