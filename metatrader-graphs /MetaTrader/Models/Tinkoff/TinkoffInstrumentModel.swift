//
//  TinkoffInstrumentModel.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 16.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation

public struct TinkoffInstrumentModel: Codable, Equatable, InstrumentModelProtocol {
  
  public var id: String {
    return self.figi
  }
  
  public var figi: String
  public var ticker: String
  public var isin: String
  public var minPriceIncrement: Double
  public var lot: Int
  public var currency: String
  public var name: String
  public var type: String
  
  // MARK: - Codable
  
  private enum CodingKeys: String, CodingKey {
      case figi = "figi"
      case ticker = "ticker"
      case isin = "isin"
      case minPriceIncrement = "minPriceIncrement"
      case lot = "lot"
      case currency = "currency"
      case name = "name"
      case type = "type"
  }
  
  // MARK: - Init
  
  internal init(figi: String,
                ticker: String,
                isin: String,
                minPriceIncrement: Double,
                lot: Int,
                currency: String,
                name: String,
                type: String) {
    self.figi = figi
    self.ticker = ticker
    self.isin = isin
    self.minPriceIncrement = minPriceIncrement
    self.lot = lot
    self.currency = currency
    self.name = name
    self.type = type
  }
  
}
