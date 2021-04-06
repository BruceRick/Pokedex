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
    var baseExperience: Int
    var height: Int
    var weight: Int
    var sprites: Sprites
    var types: [TypeListItem]
    var abilities: [AbilityListItem]
    var stats: [StatListItem]
    var moves: [MoveListItem]

    struct Sprites: Decodable {
      var frontDefault: String
    }

    struct TypeListItem: Decodable {
      var type: ListItem
    }

    struct AbilityListItem: Decodable {
      var isHidden: Bool
      var ability: ListItem
    }

    struct StatListItem: Decodable {
      var baseStat: Int
      var effort: Int
      var stat: ListItem
    }

    struct MoveListItem: Decodable {
      var move: ListItem
    }
  }
}
