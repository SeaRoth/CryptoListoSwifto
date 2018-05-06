//
//  MainState.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

import ReSwift

enum SearchState{
  case canceled
  case ready
  case searching(String)
}

enum CoinDetailState{
  case willHide(Coin)
  case hide
  case show(Coin)
}

struct MainState: StateType{
  var rank: [Int]
  var coinPages: Pages<Coin> = Pages<Coin>()
  
  var coinDetail: CoinDetailState = .hide
  
  var search: SearchState = .canceled
  
  var coins: [Coin] {
    return coinPages.values
  }
}



func mainReducer(action: Action, state: MainState?) -> MainState {
  var state = state ?? MainState()
  
  guard let action = action as? MainStateAction else {
    return state
  }
  
  switch action{
  case .fetchCoins(let length, let coins):
    
  case .showCoinDetail(_):
    <#code#>
  case .willHideCoinDetail(_):
    <#code#>
  case .hideCoinDetail:
    <#code#>
  case .readySearch:
    <#code#>
  case .search(_):
    <#code#>
  case .cancelSearch:
    <#code#>
  }
  
  case .willHideCoinDetail(let coin):
    state.coinDetail = .willHide(coin)
  case .hideCoinDetail:
    state.coinDetail = .hide
  case .showCoinDetail(let coin):
    state.coinDetail = .show(coin)
    
  case .cancelSearch:
    state.moviePages = Pages<Coin>()
    state.search = .canceled
  case .readySearch:
    state.coinPages = Pages<Coin>()
    state.search = .ready
  case .search(let query):
    state.coinPages = Pages<Coin>()
    state.search = .searchString(query)

  return state
}




let mainStore = Store(
  reducer: mainReducer,
  state: MainState(),
  middleware: []
)



