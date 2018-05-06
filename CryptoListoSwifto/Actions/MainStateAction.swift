//
//  MainStateActions.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

import ReSwift

enum MainStateAction: Action {
  case fetchCoins(length: String, coins: [Coin])
  
  case showCoinDetail(Coin)
  case willHideCoinDetail(Coin)
  case hideCoinDetail
  
  case readySearch
  case search(String)
  case cancelSearch
}
