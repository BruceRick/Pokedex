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
      if let pokemon = pokemon {
        pokemonTypes(pokemon.types.map { $0.type.name })
        baseInfo(pokemon: pokemon)
        abilities(pokemon: pokemon)
        stats(pokemon: pokemon)
        evolutions(pokemon: pokemon)
        moveList(pokemon: pokemon)
      }
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
      NavigationLink(destination: DamageRelationsView(types: types)) {
        HStack(spacing: 20) {
          ForEach(types.identifiable) { typeName in
            TypeView(type: typeName.value)
            
          }
        }
        .padding([.vertical, .trailing], 10)
      }
    }
  }

  func baseInfo(pokemon: API.Pokemon) -> some View {
    Section(header: Text("Base Info")) {
      HStack {
        Text("Base Experience:")
        Spacer()
        Text("\(pokemon.baseExperience)")
      }
      HStack {
        Text("Height:")
        Spacer()
        Text("\(pokemon.height)")
      }
      HStack {
        Text("Width:")
        Spacer()
        Text("\(pokemon.weight)")
      }
    }
  }

  func abilities(pokemon: API.Pokemon) -> some View {
    Section(header: Text("Abilities")) {
      ForEach(abilityListItems(pokemon: pokemon)) { ability in
        NavigationLink(destination: EmptyView()) {
          HStack {
            Text(ability.name.capitalized)
            if ability.isHidden {
              Text("HIDDEN")
                .foregroundColor(Color.red)
                .fontWeight(.bold)
                .padding(.leading, 20)
            }
            Spacer()
          }
        }
      }
    }
  }

  func stats(pokemon: API.Pokemon) -> some View {
    Section(header: Text("Stats")) {
      ForEach(statListItems(pokemon: pokemon)) { stat in
        HStack {
          Text(stat.name.capitalized)
          if stat.effort != 0 {
            Text("EFFORT = \(stat.effort)")
              .foregroundColor(Color.green)
              .fontWeight(.bold)
              .padding(.leading, 20)
          }
          Spacer()
          Text("\(stat.baseStat)")
        }
      }
    }
  }

  func evolutions(pokemon: API.Pokemon) -> some View {
    Section(header: Text("Evolutions")) {
      NavigationLink(destination: EmptyView()) {
        Text("Evolutions")
      }
    }
  }

  func moveList(pokemon: API.Pokemon) -> some View {
    Section(header: Text("Moves")) {
      ForEach(pokemon.moves.map { $0.move.name }.identifiable) { moveName in
        NavigationLink(destination: EmptyView()) {
          Text(moveName.value.capitalized)
        }
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

  struct Ability: Identifiable {
    var name: String
    var isHidden: Bool
    var id: String {
      name
    }
  }

  func abilityListItems(pokemon: API.Pokemon) -> [Ability] {
    pokemon.abilities.map { Ability(name: $0.ability.name, isHidden: $0.isHidden) }
  }

  struct Stat: Identifiable {
    var baseStat: Int
    var effort: Int
    var name: String
    var id: String {
      name
    }
  }

  func statListItems(pokemon: API.Pokemon) -> [Stat] {
    pokemon.stats.map { Stat(baseStat: $0.baseStat, effort: $0.effort, name: $0.stat.name) }
  }
}
