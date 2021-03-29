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
    var pokemonEntries: [Entry]

    struct Entry: Decodable {
      var entryNumber: Int
      var pokemonSpecies: Species

      struct Species: Decodable {
        var name: String
      }
    }
  }
}

extension API.Pokedex {
  static func pokemonList(from game: API.Pokedex) -> [ListViewItem] {
    game.pokemonEntries.map { ListViewItem(name: $0.pokemonSpecies.name) }
  }
}
