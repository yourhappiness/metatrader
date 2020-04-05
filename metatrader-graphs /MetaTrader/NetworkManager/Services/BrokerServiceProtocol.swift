//
//  BrokerServiceProtocol.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 25.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import Alamofire

protocol BrokerServiceProtocol: class {
  func getInstrument(byTicker ticker: String, then completion: @escaping (Result<[InstrumentModelProtocol]>) -> Void)
  
  func getInstrumentsWithQuotesAndCandles(forTicker ticker: String,
                                          from: Date,
                                          to: Date,
                                          withInterval interval: String,
                                          then completion: @escaping (Result<[InstrumentModelWithQuoteAndCandles]>) -> Void)
  
  func getCandles(byFIGI figi: String,
                  from: Date,
                  to: Date,
                  withInterval interval: String,
                  then completion: @escaping (Result<[CandleModelProtocol]>) -> Void)
}
