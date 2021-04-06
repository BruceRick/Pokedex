//
//  PokedexListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI

struct PokedexListView: View {
  var game: String? = nil

  @ViewBuilder var body: some View {
    switch game {
    case .none:
      pokedexList
    case .some(let game):
      pokedexList(game: game)
    }
  }

  var pokedexList: some View {
    APIContentView(endpoint: .pokedexes, responseMap: pokedexes(resultList:)) { pokedexes in
      pokedexList(pokedexes: pokedexes ?? [])
    }
  }

  func pokedexList(game: String) -> some View {
    APIContentView(endpoint: .game(game), responseMap: pokedexes(game:)) { pokedexes in
      pokedexList(pokedexes: pokedexes ?? []).navigationTitle(game)
    }
  }

  func pokedexList(pokedexes: [IdentifiableString]) -> some View {
    List(pokedexes) { pokedexName in
      NavigationLink(destination: PokemonListView(pokedex: pokedexName.value)) {
        Text(pokedexName.value)
      }
    }
  }

  func pokedexes(resultList: API.ResultList) -> [IdentifiableString] {
    resultList.results.map { $0.name }.identifiable
  }

  func pokedexes(game: API.Game) -> [IdentifiableString] {
    game.pokedexes.map { $0.name }.identifiable
  }
}
