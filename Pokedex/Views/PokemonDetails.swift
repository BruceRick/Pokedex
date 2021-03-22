//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-22.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct PKType: Identifiable {
  var name: String
  var id: String { name }
}

struct PokemonDetails: View {
  let pokemonName: String
  @State private var pokemon: API.Pokemon?
  @State private var types: [PKType] = []
  @State private var cancellable: AnyCancellable?
  @State private var imageLoader = ImageLoader(urlString: "")
  @State var sprite: UIImage = UIImage()
  
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
    .onAppear {
      fetchPokemonDetails()
    }
  }

  func fetchPokemonDetails() {
    cancellable = API.Request(endpoint: .pokemon(pokemonName))
      .dataTaskPublisher()
      .map(\.data)
      .map { (pokemonDetails: API.Pokemon) -> API.Pokemon in
        return pokemonDetails
      }
      .sink(
        receiveCompletion: { _ in },
        receiveValue: {
          pokemon = $0
          if let pokemon = pokemon {
            imageLoader = ImageLoader(urlString: pokemon.sprites.frontDefault)
            types = pokemon.types.map { PKType(name: $0.type.name) }
          }
        })
  }
}
