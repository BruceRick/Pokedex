//
//  APIContentView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-04-05.
//

import SwiftUI
import Combine

struct APIContentView<Content: View, ResponseObject: Decodable, Data>: View {
  let endpoint: API.Endpoint
  var responseMap: (ResponseObject) -> Data
  var content: (Data?) -> Content
  @State var state = LoadingState.initial

  @State var data: Data? = nil { didSet { didSetData() } }
  @State private var cancellable: AnyCancellable?

  var body: some View {
    content(data)
      .loading(state == .initial || state == .loading)
      .onAppear(perform: loadData)
  }

  func loadData() {
    guard state != .success || state != .loading else { return }
    cancellable = API.Request(endpoint: endpoint)
      .dataTaskPublisher()
      .map(\.data)
      .map(responseMap)
      .replaceError(with: nil)
      .assign(to: \.data, on: self)
  }

  func didSetData() {
    switch data {
    case .some(_):
      state = .success
    case .none:
      state = .error
    }
  }
}

extension APIContentView {
  enum LoadingState {
    case initial
    case loading
    case success
    case error
  }
}
