//
//  File.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import Foundation

extension API {
  struct Game: Decodable {
    var name: String
    var order: Int
    var id: Int
    var pokedexes: [ListItem]
  }
}
