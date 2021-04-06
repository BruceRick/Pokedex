//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-22.
//

import SwiftUI
import Combine

struct PokemonDetailsView: View {
  let pokemonName: String

  @State private var imageLoader = ImageLoader(urlString: "")
  @State private var pokemonImage = UIImage()
  
  @ViewBuilder var body: some View {
    APIContentView(endpoint: .pokemon(pokemonName), responseMap: pokemon) { pokemon in
      content(pokemon: pokemon)
        .navigationTitle(pokemonName.capitalized)
        .onAppear { loadSprite(pokemon: pokemon) }
        .onReceive(imageLoader.didChange, perform: imageLoaded)
    }
  }

  func content(pokemon: API.Pokemon?) -> some View {
    List {
      pokemonSprite
      pokemonTypes(pokemon?.types.map { $0.type.name } ?? [])
    }
  }

  var pokemonSprite: some View {
    HStack {
      Spacer()
      Image(uiImage: pokemonImage)
        .resizable()
        .frame(width: 200, height: 200)
        .loading(pokemonImage == UIImage())
        .padding(.top, 20)
      Spacer()
    }
  }

  func pokemonTypes(_ types: [String]) -> some View {
    Section(header: Text("Type")) {
      NavigationLink(destination: PokemonTypesListView(types: types)) {
        HStack(spacing: 20) {
          ForEach(types.identifiable) { typeName in
            PokemonTypeView(type: typeName.value)
            
          }
        }
        .padding([.vertical, .trailing], 10)
      }
    }
  }

  func pokemon(from pokemon: API.Pokemon) -> API.Pokemon {
    pokemon
  }

  func loadSprite(pokemon: API.Pokemon?) {
    if let urlString = pokemon?.sprites.frontDefault {
      imageLoader = ImageLoader(urlString: urlString)
    }
  }

  func imageLoaded(data: Data) {
    pokemonImage = UIImage(data: data) ?? UIImage()
  }
}
