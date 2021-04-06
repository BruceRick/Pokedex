//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI

struct PokemonListView: View {
  var pokedex: String
  var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.minimumIntegerDigits = 3
    return formatter
  }()

  struct Pokemon: Identifiable {
    var name: String
    var entry: NSNumber
    var id: String {
      name
    }
  }

  var body: some View {
    APIContentView(endpoint: .pokedex(pokedex), responseMap: pokemon) { pokemonList in
      List(pokemonList ?? []) { pokemon in
        NavigationLink(destination: PokemonDetailsView(pokemonName: pokemon.name)) {
          Text("\(formatter.string(from: pokemon.entry) ?? "???")   \(pokemon.name.capitalized)")
        }
      }
      .navigationTitle(pokedex.capitalized)
    }
  }

  func pokemon(pokedex: API.Pokedex) -> [Pokemon] {
    pokedex.pokemonEntries.map { Pokemon(name: $0.pokemonSpecies.name, entry: NSNumber(value: $0.entryNumber)) }
  }
}
