//
//  LoadingModifier.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-28.
//

import Foundation
import SwiftUI

public struct LoadingModifier: ViewModifier {
  let loading: Bool
  @State private var degrees = 0.0

  @ViewBuilder public func body(content: Content) -> some View {
    Group {
      if !loading {
        content
      } else {
        ZStack {
          content.opacity(0)
          loadingView
        }
      }
    }
    .transition(.opacity)
  }

  var loadingView: some View {
    Image("Loading")
      .resizable()
      .frame(width: 50, height: 50)
      .rotationEffect(.degrees(degrees))
      .padding(.bottom, 20)
      .onAppear {
        let repeated = Animation
          .easeInOut(duration: 0.75)
          .repeatForever(autoreverses: false)
        return withAnimation(repeated) {
          degrees = 360
        }
      }.onDisappear {
        degrees = 0
      }
  }
}

public extension View {
  func loading(_ loading: Bool) -> some View {
    modifier(LoadingModifier(loading: loading))
  }
}
