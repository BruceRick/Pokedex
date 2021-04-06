//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI

struct PokemonListView: View {
  var pokedex: String

  var body: some View {
    APIContentView(endpoint: .pokedex(pokedex), responseMap: pokemon) { pokemonList in
      List(pokemonList ?? []) { pokemonName in
        NavigationLink(destination: PokemonDetailsView(pokemonName: pokemonName.value)) {
          Text(pokemonName.value.capitalized)
        }
      }
      .navigationTitle(pokedex)
    }
  }

  func pokemon(pokedex: API.Pokedex) -> [IdentifiableString] {
    pokedex.pokemonEntries.map { $0.pokemonSpecies.name }.identifiable
  }
}
