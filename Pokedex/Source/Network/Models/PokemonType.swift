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
      var doubleDamageFrom: [ListItem]
      var doubleDamageTo: [ListItem]
      var halfDamageFrom: [ListItem]
      var halfDamageTo: [ListItem]
      var noDamageFrom: [ListItem]
      var noDamageTo: [ListItem]
    }
  }
}
