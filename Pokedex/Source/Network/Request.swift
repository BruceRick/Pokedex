//
//  APIRequest.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import Foundation
import Combine

extension API {
  struct Response<T> {
    let data: T
    let response: URLResponse
  }
  
  struct Request {
    let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
      self.endpoint = endpoint
    }
    
    func dataTaskPublisher<T: Decodable>() -> AnyPublisher<API.Response<T>, Error> {
      let url = API.baseURL.appendingPathComponent(endpoint.path)
      let urlRequest = URLRequest(url: url)
      let publisher = URLSession.shared
        .dataTaskPublisher(for: urlRequest)
        .tryMap { result -> API.Response<T> in
          try? debugPrint(response: result.response, data: result.data)
          let data = try API.jsonDecoder.decode(T.self, from: result.data)
          return API.Response(data: data, response: result.response)
        }
        .receive(on: API.scheduler)
        .eraseToAnyPublisher()
      return publisher
    }

    func debugPrint(response: URLResponse, data: Data) throws {
        let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: [])
        let responseFormat = "---------HTTP RESPONSE-------\n"
        let dataFormat = "--------DATA--------"
        print(responseFormat, response, dataFormat, jsonDictionary, separator: "\n", terminator: "-------------\n\n")
    }
  }
}
