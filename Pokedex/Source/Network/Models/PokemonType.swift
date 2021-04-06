//
//  PokemonType.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import Foundation

extension API {
  struct PokemonType: Decodable {
    var damageRelations: DamageRelations

    struct DamageRelations: Decodable {
      var doubleDamageFrom: [API.ListItem]
      var doubleDamageTo: [API.ListItem]
      var halfDamageFrom: [API.ListItem]
      var halfDamageTo: [API.ListItem]
      var noDamageFrom: [API.ListItem]
      var noDamageTo: [API.ListItem]
    }
  }
}
