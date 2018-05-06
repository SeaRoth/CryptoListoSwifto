//
//  CoinDetailViewState.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

struct CoinDetailViewState {
  let coin: Coin?
  
  let name: String
  let price: Double
  let symbol: String
  let rank: Int
  
  init(_ state: MainState) {
    switch state.coinDetail {
    case .willHide(let coin):
      self.coin = coin
    case .hide:
      self.coin = nil
    case .show(let coin):
      self.coin = coin
    }
    
    name = coin?.name ?? "no name"
    price = coin?.quotes?.price ?? "no price"
    symbol = coin?.symbol ?? "no symbol"
    rank = coin?.rank ?? "no rank"
    
    
    
  }
}
