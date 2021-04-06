//
//  PokemonTypeView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import Foundation

import SwiftUI

struct PokemonTypeView: View {
  var type: String

  var body: some View {
    HStack(alignment: .center) {
      Spacer()
      Image(type)
        .resizable()
        .frame(width: 20, height: 20)
      Text(type.capitalized)
        .frame(alignment: .leading)
        .font(.headline)
        .foregroundColor(.white)
      .buttonStyle(PlainButtonStyle())
      Spacer()
    }
    .padding(10)
    .background(Color(type))
    .clipShape(Capsule())
  }
}
