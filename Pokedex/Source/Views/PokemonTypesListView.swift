//
//  PokemonTypesListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import Foundation

import SwiftUI

struct PokemonTypesListView: View {
  var types: [String]

  var body: some View {
    ScrollView {
      LazyVStack( pinnedViews: .sectionHeaders) {
        ForEach(types.identifiable) { typeName in
          Section(header: header(type: typeName.value)) {
            typeDetails(type: typeName.value)
          }
        }.navigationTitle("Types")
      }
    }
  }

  func header(type: String) -> some View {
    VStack(alignment: .center) {
      PokemonTypeView(type: type)
    }
    .frame(height: 60)
    .frame(maxHeight: .infinity)
    .background(Color(type))
  }

  func typeDetails(type: String) -> some View {
    APIContentView(endpoint: .type(type), responseMap: pokemonType) { type in
      VStack(spacing: 10) {
        doubleDamageFrom(damageRelations: type?.damageRelations)
        doubleDamageTo(damageRelations: type?.damageRelations)
        halfDamageFrom(damageRelations: type?.damageRelations)
        halfDamageTo(damageRelations: type?.damageRelations)
        noDamageFrom(damageRelations: type?.damageRelations)
        noDamageTo(damageRelations: type?.damageRelations)
      }.padding(.horizontal, 10)
    }
  }

  func damageRelation(text: String, types: [String]) -> some View {
    VStack(alignment: .leading) {
      Text(text)
        .fontWeight(.bold)
        .padding(.vertical, 10)
      typeList(types: types)
    }
    .frame(maxWidth: .infinity)
  }

  @ViewBuilder func typeList(types: [String]) -> some View {
    if types.isEmpty {
      HStack {
        Spacer()
        Text("None")
        Spacer()
      }
    } else {
      ForEach(types.identifiable) { typeName in
        PokemonTypeView(type: typeName.value)
      }
    }
  }

  func doubleDamageFrom(damageRelations: API.PokemonType.DamageRelations?) -> some View {
    let types = damageRelations?.doubleDamageFrom.map { $0.name } ?? []
    return damageRelation(text: "Double damage from:", types: types)
  }

  func doubleDamageTo(damageRelations: API.PokemonType.DamageRelations?) -> some View {
    let types = damageRelations?.doubleDamageTo.map { $0.name } ?? []
    return damageRelation(text: "Double damage to:", types: types)
  }

  func halfDamageFrom(damageRelations: API.PokemonType.DamageRelations?) -> some View {
    let types = damageRelations?.halfDamageFrom.map { $0.name } ?? []
    return damageRelation(text: "Half damage from:", types: types)
  }

  func halfDamageTo(damageRelations: API.PokemonType.DamageRelations?) -> some View {
    let types = damageRelations?.halfDamageTo.map { $0.name } ?? []
    return damageRelation(text: "Half damage to:", types: types)
  }

  func noDamageFrom(damageRelations: API.PokemonType.DamageRelations?) -> some View {
    let types = damageRelations?.noDamageFrom.map { $0.name } ?? []
    return damageRelation(text: "No damage from:", types: types)
  }

  func noDamageTo(damageRelations: API.PokemonType.DamageRelations?) -> some View {
    let types = damageRelations?.noDamageTo.map { $0.name } ?? []
    return damageRelation(text: "No damage to:", types: types)
  }

  func pokemonType(from type: API.PokemonType) -> API.PokemonType {
    type
  }
}
