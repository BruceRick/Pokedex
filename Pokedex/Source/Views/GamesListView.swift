//
//  GamesListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI

struct GamesListView: View {
  var body: some View {
    APIContentView(endpoint: .games, responseMap: games) { gameNames in
      List(gameNames ?? []) { gameName in
        NavigationLink(destination: PokedexListView(game: gameName.value)) {
          Text(gameName.value.capitalized)
        }
      }
    }
  }

  func games(from resultList: API.ResultList) -> [IdentifiableString] {
    resultList.results.map { $0.name }.identifiable
  }
}
