//
//  CoinListViewState.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

struct CoinListViewState{
  let coins: [Coin]
  let searchBarText: String
  let searchBarShowsCancel: Bool
  let searchBarFirstResponder: Bool
  
  init(_ state: MainState){
    coins = state.coins
    
    switch(state.search){
    case .canceled:
      searchBarText = ""
      searchBarShowsCancel = false
      searchBarFirstResponder = false
    case.ready:
      searchBarText = ""
      searchBarShowsCancel = true
      searchBarFirstResponder = true
    case .searching(let text):
      searchBarText = text
      searchBarShowsCancel = true
      searchBarFirstResponder = true
    }
  }
}
