//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-22.
//

import SwiftUI
import Combine

struct PokemonDetails: View {
  let pokemonName: String

  @State private var pokemon: API.Pokemon? { didSet { didSetPokemon() } }
  @State private var types: [PokemonType] = []
  @State private var cancellable: AnyCancellable?
  @State private var imageLoader = ImageLoader(urlString: "")
  @State private var sprite: UIImage = UIImage()
  @State private var loaded = false

  struct PokemonType: Identifiable {
    var name: String
    var id: String { name }
  }
  
  var body: some View {
    VStack {
      Image(uiImage: sprite)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 300, height: 300)
        .onReceive(imageLoader.didChange) { data in
          self.sprite = UIImage(data: data) ?? UIImage()
        }
      if let _ = pokemon {
        ForEach(types) { type in
          Text(type.name)
        }
      }
      Spacer()
    }
    .onAppear(perform: onAppear)
    .loading(cancellable != nil)
  }

  func fetchPokemonDetails() {
    cancellable = API.Request(endpoint: .pokemon(pokemonName))
      .dataTaskPublisher()
      .map { (response: API.Response) -> API.Pokemon in response.data }
      .replaceError(with: nil)
      .assign(to: \.pokemon, on: self)
  }

  func onAppear() {
    if !loaded {
      fetchPokemonDetails()
    }
    loaded = true
  }

  func didSetPokemon() {
    if let pokemon = pokemon {
      imageLoader = ImageLoader(urlString: pokemon.sprites.frontDefault)
      types = pokemon.types.map { PokemonType(name: $0.type.name) }
    }
    cancellable = nil
  }
}
