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
      HStack(spacing: 20) {
        NavigationLink(destination: EmptyView()) {
          ForEach(types.identifiable) { typeName in
            typeCell(typeName.value)
          }
        }
      }
      .padding(.vertical, 10)
    }
  }

  func typeCell(_ name: String) -> some View {
    HStack(alignment: .center) {
      Spacer()
      Image(name)
        .resizable()
        .frame(width: 20, height: 20)
      Text(name.capitalized)
        .frame(alignment: .leading)
        .font(.headline)
        .foregroundColor(.white)
      .buttonStyle(PlainButtonStyle())
      Spacer()
    }
    .padding(10)
    .background(Color(name))
    .clipShape(Capsule())
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
