//
//  ContentView.swift
//  Pokedex
//
//  Created by Bruce Rick on 2021-03-21.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    NavigationView {
      List {
        cell(text: "Games", iconName: "gamecontroller.fill", destination: GamesListView())
        cell(text: "Pokedexes", iconName: "book.fill", destination: PokedexListView())
      }
      .navigationBarTitle(Text("Pokemon Database"))
    }
  }
}

func cell<Destination: View>(text: String, iconName: String, destination: Destination) -> some View {
  NavigationLink(destination: destination.navigationTitle(text)) {
    HStack {
      Image(systemName: iconName)
        .font(.system(size: 22, weight: .regular))
        .frame(width: 30, height: 22)
        .padding(.horizontal, 5)
      Text(text)
      Spacer()
    }.frame(minHeight: 44)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
