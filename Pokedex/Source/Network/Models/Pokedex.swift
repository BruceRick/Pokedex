//
//  Pokedex.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import Foundation

extension API {
  struct Pokedex: Decodable {
    var name: String
    var id: Int
    var pokemonEntries: [Pokemon]

    struct Pokemon: Decodable {
      var entryNumber: Int
      var pokemonSpecies: ListItem
    }
  }
}
