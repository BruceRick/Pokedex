//
//  Endpoint.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import Foundation

extension API {
  enum Endpoint {
    case game(String)
    case games
    case pokedexes
    case pokedex(String)
    case pokemon(String)
    
    var path: String {
      switch self {
      case .games:
        return "version-group"
      case .pokedexes:
        return "pokedex"
      case .game(let name):
        return "\(Self.games.path)/\(name)"
      case .pokedex(let name):
        return "\(Self.pokedexes.path)/\(name)"
      case .pokemon(let name):
        return "pokemon/\(name)"
      }
    }
  }
}
