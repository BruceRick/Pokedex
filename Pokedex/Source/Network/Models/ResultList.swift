//
//  ListItem.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import Foundation

extension API {
  struct ResultList: Decodable {
    var results: [ListItem]
  }
}

extension API.ResultList {
  static func list(from resultList: API.ResultList) -> [ListViewItem] {
    resultList.results.map { ListViewItem(name: $0.name) }
  }
}
