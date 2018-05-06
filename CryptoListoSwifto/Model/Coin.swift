//
//  Coin.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

import Foundation

struct Coin: Codable{
  let id: Int?
  let name: String?
  let symbol: String?
  let websiteSlug: String?
  let rank: Int?
  let circulatingSupply: Int?
  let totalSupply: Int?
  let maxSupply: Int?
  let quotes: Quote?
  let lastUpdated: Int?
  
  private enum CodingKeys: String, CodingKey{
    case id
    case name
    case symbol
    case websiteSlug = "website_slug"
    case rank
    case circulatingSupply = "circulating_supply"
    case totalSupply = "total_supply"
    case maxSupply = "max_supply"
    case quotes
    case lastUpdated = "last_updated"
  }
}
