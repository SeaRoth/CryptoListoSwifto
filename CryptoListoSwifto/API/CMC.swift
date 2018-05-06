//
//  CMC.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

import Foundation

struct CMCResult<T: Codable>: Codable{
  let results: [Coin]
  
  private enum CodingKeys: String, CodingKey{
    case results
  }
}

protocol CMCFetcher {
  func fetchCoins(completion: @escaping ([Coins]? -> Void))
}

class CMC: CMCFetcher{
  let baseUrl = "https://api.coinmarketcap.com/v2/ticker/"
  
  func fetchCoins(limit: String, completion: @escaping ([Coin]?) -> Void){
    fetch(
      url: "\(baseUrl)?limit=\(limit)",
      completion: completion
    )
  }
  
  func fetch<T: Codable>(url: String, completion: @escaping (T?) -> Void) {
    guard let url = URL(string: url) else { return completion(nil) }
    
    let task = URLSession.shared.dataTask(with: url) { data, _, _ in
      guard
        let data = data,
        let obj = try? JSONDecoder().decode(T.self, from: data)
        else {
          return completion(nil)
      }
      
      completion(obj)
    }
    
    task.resume()
  }
}
