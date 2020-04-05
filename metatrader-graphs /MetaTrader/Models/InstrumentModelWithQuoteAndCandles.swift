//
//  InstrumentModelWithQuoteAndCandles.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 17.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation

struct InstrumentModelWithQuoteAndCandles: Identifiable, Equatable {

  let instrument: InstrumentModelProtocol
  let quote: Double
  let candles: [Candle]
  
  public var id: String {
    return self.instrument.id
  }
  
  public var name: String {
    return self.instrument.name
  }
  public var currency: String {
    return self.instrument.currency
  }
  public var figi: String {
    return self.instrument.figi
  }
  public var ticker: String {
    return self.instrument.ticker
  }
  
  static func == (lhs: InstrumentModelWithQuoteAndCandles, rhs: InstrumentModelWithQuoteAndCandles) -> Bool {
    if lhs.id == rhs.id &&
      lhs.name == rhs.name &&
      lhs.currency == rhs.currency &&
      lhs.figi == rhs.figi &&
      lhs.ticker == rhs.ticker {
      return true
    } else {
      return false
    }
  }
}
