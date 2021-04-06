//
//  DamageRelationsView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import Foundation

import SwiftUI

struct DamageRelationsView: View {
  var types: [String]

  var body: some View {
    ScrollView {
      LazyVStack( pinnedViews: .sectionHeaders) {
        ForEach(types.identifiable) { typeName in
          Section(header: header(type: typeName.value)) {
            typeDetails(type: typeName.value)
          }
        }.navigationTitle("Damage Relations")
      }
    }
  }

  func header(type: String) -> some View {
    VStack(alignment: .center) {
      TypeView(type: type)
    }
    .frame(height: 60)
    .frame(maxHeight: .infinity)
    .background(Color(type))
  }

  func typeDetails(type: String) -> some View {
    APIContentView(endpoint: .type(type), responseMap: pokemonType) { type in
      VStack(spacing: 10) {
        damageRelation(text: "Double damage from:", types: type?.damageRelations.doubleDamageFrom)
        damageRelation(text: "Double damage to:", types: type?.damageRelations.doubleDamageTo)
        damageRelation(text: "Half damage from:", types: type?.damageRelations.halfDamageFrom)
        damageRelation(text: "Half damage to:", types: type?.damageRelations.halfDamageTo)
        damageRelation(text: "No damage from:", types: type?.damageRelations.noDamageFrom)
        damageRelation(text: "No damage to:", types: type?.damageRelations.noDamageTo)
      }.padding([.horizontal, .bottom], 10)
    }
  }

  func damageRelation(text: String, types: [API.ListItem]?) -> some View {
    VStack(alignment: .leading) {
      Text(text)
        .fontWeight(.bold)
        .padding(.vertical, 10)
      typeList(types: types?.map { $0.name } ?? [])
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
        TypeView(type: typeName.value)
      }
    }
  }

  func pokemonType(from type: API.PokemonType) -> API.PokemonType {
    type
  }
}
