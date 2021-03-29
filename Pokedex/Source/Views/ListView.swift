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
  @State private var items: [ListViewItem]?
  @State private var cancellable: AnyCancellable?

  var body: some View {
    List {
      if let items = items {
        ForEach(items) { item in
          NavigationLink(destination: destination(item.name)) {
            Text(item.name)
          }
        }
      }
    }
    .onAppear {
      fetchListItems()
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
}

//struct ListView_Previews: PreviewProvider {
//  static var previews: some View {
//    ListView(endpoint: .games, destination)
//  }
//}
