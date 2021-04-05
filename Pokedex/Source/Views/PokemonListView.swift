//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI

struct PokemonListView: View {
  struct Pokemon: Identifiable {
    var name: String
    var id: String { name }
  }

  var pokedex: String

  var body: some View {
    APIContentView(endpoint: .pokedex(pokedex), responseMap: pokemon) { (pokemonList: [Pokemon]?) in
      List {
        ForEach(pokemonList ?? []) { pokemon in
          NavigationLink(destination: PokemonDetailsView(pokemonName: pokemon.name)) {
            Text(pokemon.name)
          }
        }
      }
      .navigationTitle(pokedex)
    }
  }

  func pokemon(pokedex: API.Pokedex) -> [Pokemon] {
    pokedex.pokemonEntries.map { Pokemon(name: $0.pokemonSpecies.name) }
  }
}
