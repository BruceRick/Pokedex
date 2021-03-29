//
//  API.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import Foundation
import Combine

enum API {
  static let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
  static let scheduler = DispatchQueue.main
  static let jsonDecoder: JSONDecoder = {
    var decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
}
