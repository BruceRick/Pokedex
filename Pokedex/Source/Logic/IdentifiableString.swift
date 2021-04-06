//
//  IdentifiableString.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import Foundation

struct IdentifiableString: Identifiable {
  var value: String
  var id: String { value }
}

extension Array where Element == String {
  var identifiable: [IdentifiableString] {
    map { IdentifiableString(value: $0) }
  }
}
