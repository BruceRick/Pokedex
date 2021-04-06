//
//  RoundedBorderModifier.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI

public struct RoundedBorderModifier: ViewModifier {

  var radius: CGFloat
  var width: CGFloat
  var color: Color

  public func body(content: Content) -> some View {
    content
      .clipShape(RoundedRectangle(cornerRadius: radius))
      .overlay(overlay)
  }

  var overlay: some View {
    RoundedRectangle(cornerRadius: radius)
      .stroke(color, lineWidth: width)
  }
}

public extension View {
  func roundedOutline(radius: CGFloat, width: CGFloat, color: Color) -> some View {
    modifier(RoundedBorderModifier(radius: radius, width: width, color: color))
  }
}


