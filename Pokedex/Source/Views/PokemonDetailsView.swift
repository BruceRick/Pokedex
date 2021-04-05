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

  struct Pokemon {
    var spriteURLString: String
    var types: [PokemonType]
  }

  struct PokemonType: Identifiable {
    var name: String
    var id: String { name }
  }
  
  @ViewBuilder var body: some View {
    APIContentView(endpoint: .pokemon(pokemonName), responseMap: pokemon) { (pokemon: Pokemon?) in
      VStack {
        Image(uiImage: pokemonImage)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 300, height: 300)
          .loading(pokemonImage == UIImage())
        ForEach(pokemon?.types ?? []) { type in
          Text(type.name)
        }
        Spacer()
      }
      .navigationTitle(pokemonName)
      .onAppear {
        if let urlString = pokemon?.spriteURLString {
          imageLoader = ImageLoader(urlString: urlString)
        }
      }
      .onReceive(imageLoader.didChange, perform: imageLoaded)
    }
  }

  func pokemon(from pokemon: API.Pokemon) -> Pokemon {
    Pokemon(spriteURLString: pokemon.sprites.frontDefault, types: pokemon.types.map { PokemonType(name: $0.type.name) })
  }

  func imageLoaded(data: Data) {
    pokemonImage = UIImage(data: data) ?? UIImage()
  }
}
