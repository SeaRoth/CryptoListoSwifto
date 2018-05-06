//
//  ActionCreators.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

import ReSwift

func fetchCoins(state: MainState, store: Store<MainState>) -> Action? {
  CMC().fetchCoins(limit: String){ result in
    guard let result = result else { return }
    DispatchQueue.main.async{
      mainStore.dispatch(
          MainStateAction.fetchCoins(coins: result.results)
      )
    }
  }
}
