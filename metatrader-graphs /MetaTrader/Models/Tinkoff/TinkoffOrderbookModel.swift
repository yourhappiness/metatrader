//
//  TinkoffOrderbookModel.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 16.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation

public struct TinkoffOrderbookModel: Codable {
  
  public var figi: String
  public var depth: Int
  public var bids: [TinkoffBidsAsksModel]
  public var asks: [TinkoffBidsAsksModel]
  public var tradeStatus: String
  public var minPriceIncrement: Double
  public var lastPrice: Double
  public var closePrice: Double
  public var limitUp: Double?
  public var limitDown: Double?
  
  // MARK: - Codable
  
  private enum CodingKeys: String, CodingKey {
      case figi = "figi"
      case depth = "depth"
      case bids = "bids"
      case asks = "asks"
      case tradeStatus = "tradeStatus"
      case minPriceIncrement = "minPriceIncrement"
      case lastPrice = "lastPrice"
      case closePrice = "closePrice"
      case limitUp = "limitUp"
      case limitDown = "limitDown"
  }
  
  // MARK: - Init
  
  internal init(figi: String,
                depth: Int,
                bids: [TinkoffBidsAsksModel],
                asks: [TinkoffBidsAsksModel],
                tradeStatus: String,
                minPriceIncrement: Double,
                lastPrice: Double,
                closePrice: Double,
                limitUp: Double?,
                limitDown: Double?) {
    self.figi = figi
    self.depth = depth
    self.bids = bids
    self.asks = asks
    self.tradeStatus = tradeStatus
    self.minPriceIncrement = minPriceIncrement
    self.lastPrice = lastPrice
    self.closePrice = closePrice
    self.limitUp = limitUp
    self.limitDown = limitDown
  }
  
}
