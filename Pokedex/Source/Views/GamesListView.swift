//
//  GamesListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI

struct GamesListView: View {
  struct Game: Identifiable {
    var name: String
    var id: String { name }
  }

  var body: some View {
    APIContentView(endpoint: .games, responseMap: games) { (games: [Game]?) in
      List {
        ForEach(games ?? []) { game in
          NavigationLink(destination: PokedexListView(game: game.name)) {
            Text(game.name)
          }
        }
      }
    }
  }

  func games(from resultList: API.ResultList) -> [Game] {
    resultList.results.map { Game(name: $0.name) }
  }
}
