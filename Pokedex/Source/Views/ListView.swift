//
//  ListView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import SwiftUI
import Combine

struct ListViewItem: Decodable, Identifiable {
  var name: String
  var id: String { name }
}

struct ListView<Destination: View, ResponseObject: Decodable>: View {
  let endpoint: API.Endpoint
  let destination: (String) -> Destination
  let responseMap: (ResponseObject) -> [ListViewItem]

  @State private var items: [ListViewItem]? { didSet { didSetItems() } }
  @State private var cancellable: AnyCancellable?
  @State private var loaded = false

  var body: some View {
    content
      .onAppear(perform: onAppear)
      .loading(cancellable != nil)
  }

  @ViewBuilder var content: some View {
    if let items = items {
      list(items)
    } else {
      noContent
    }
  }

  func list(_ items: [ListViewItem]) -> some View {
    List {
      ForEach(items) { item in
        NavigationLink(destination: destination(item.name)) {
          Text(item.name)
        }
      }
    }
  }

  @ViewBuilder var noContent: some View {
    VStack {
      Spacer()
      Text("No Content")
      Spacer()
    }
  }

  func fetchListItems() {
    cancellable = API.Request(endpoint: endpoint)
      .dataTaskPublisher()
      .map(\.data)
      .map(responseMap)
      .replaceError(with: [])
      .assign(to: \.items, on: self)
  }

  func onAppear() {
    if !loaded {
      fetchListItems()
    }
    loaded = true
  }

  func didSetItems() {
    cancellable = nil
  }
}

//struct ListView_Previews: PreviewProvider {
//  static var previews: some View {
//    ListView(endpoint: .games, destination)
//  }
//}
