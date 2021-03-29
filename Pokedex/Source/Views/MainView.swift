//
//  ContentView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    NavigationView {
      List {
        cell(text: "Games", iconName: "gamecontroller.fill", destination: gamesListView)
        cell(text: "Pokedexes", iconName: "book.fill", destination: pokedexListView)
      }
      .navigationBarTitle(Text("Pokemon Database"))
    }
  }
}

func cell<T: View>(text: String, iconName: String, destination: T) -> some View {
  NavigationLink(destination: destination.navigationTitle(text)) {
    HStack {
      Image(systemName: iconName)
        .font(.system(size: 22, weight: .regular))
        .frame(width: 30, height: 22)
        .padding(.horizontal, 5)
      Text(text)
      Spacer()
    }.frame(minHeight: 44)
  }
}

var gamesListView: some View {
  ListView(endpoint: .games, destination: gamePokedexListView, responseMap: API.ResultList.list)
}

var pokedexListView: some View {
  ListView(endpoint: .pokedexes, destination: pokemonListView, responseMap: API.ResultList.list)
}

func gamePokedexListView(game: String) -> some View {
  ListView(endpoint: .game(game), destination: pokemonListView, responseMap: API.Game.pokedexList).navigationTitle(game)
}

func pokemonListView(pokedex: String) -> some View {
  ListView(endpoint: .pokedex(pokedex), destination: pokemonDetails, responseMap: API.Pokedex.pokemonList).navigationTitle(pokedex)
}

func pokemonDetails(name: String) -> some View {
  PokemonDetails(pokemonName: name).navigationTitle(name)
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
