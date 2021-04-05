//
//  PokedexListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI

struct PokedexListView: View {
  struct Pokedex: Identifiable {
    var name: String
    var id: String { name }
  }

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
    APIContentView(endpoint: .pokedexes, responseMap: pokedexes(resultList:)) { (pokedexes: [Pokedex]?) in
      pokedexList(pokedexes: pokedexes ?? [])
    }
  }

  func pokedexList(game: String) -> some View {
    APIContentView(endpoint: .game(game), responseMap: pokedexes(game:)) { (pokedexes: [Pokedex]?) in
      pokedexList(pokedexes: pokedexes ?? []).navigationTitle(game)
    }
  }

  func pokedexList(pokedexes: [Pokedex]) -> some View {
    List {
      ForEach(pokedexes) { pokedex in
        NavigationLink(destination: PokemonListView(pokedex: pokedex.name)) {
          Text(pokedex.name)
        }
      }
    }
  }

  func pokedexes(resultList: API.ResultList) -> [Pokedex] {
    resultList.results.map { Pokedex(name: $0.name) }
  }

  func pokedexes(game: API.Game) -> [Pokedex] {
    game.pokedexes.map { Pokedex(name: $0.name) }
  }
}
