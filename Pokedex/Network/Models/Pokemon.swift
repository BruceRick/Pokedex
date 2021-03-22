//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-22.
//

import Foundation

extension API {
  struct Pokemon: Decodable {
    var name: String
    var sprites: Sprites
    var types: [PokemonTypes]

    struct Sprites: Decodable {
      var frontDefault: String
    }

    struct PokemonTypes: Decodable {
      var type: PokemonType

      struct PokemonType: Decodable {
        var name: String
      }
    }
  }
}
