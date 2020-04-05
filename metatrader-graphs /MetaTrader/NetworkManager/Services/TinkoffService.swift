//
//  TinkoffService.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 25.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import Alamofire

enum FetchingError: Error {
  case noSuchInstruments
}

final class TinkoffService: BrokerServiceProtocol {
  internal let networkService = TinkoffNetworkService()
  
  //максимальное количество свечей для корректного расчета интерфейса (временная мера)
    let maxCandlesCount = 45
  
  func sandboxRegister(forToken token: String, then completion: @escaping (Result<TinkoffRegisterModel>) -> Void) {
    self.networkService.sandboxRegister(forToken: token, then: completion)
  }
  
  func getInstrument(byTicker ticker: String,
                     then completion: @escaping (Result<[InstrumentModelProtocol]>) -> Void) {
    self.networkService.getInstrument(byTicker: ticker, then: completion)
  }
  
  func getOrderbook(byFIGI figi: String,
                    withDepth depth: Int,
                    then completion: @escaping (Result<TinkoffOrderbookModel>) -> Void) {
    self.networkService.getOrderbook(byFIGI: figi, withDepth: depth, then: completion)
  }
  
  func getCandles(byFIGI figi: String,
                  from: Date,
                  to: Date,
                  withInterval interval: String,
                  then completion: @escaping (Result<[CandleModelProtocol]>) -> Void) {
    self.networkService.getCandles(byFIGI: figi, from: from, to: to, withInterval: interval, then: completion)
  }
  
  func getQuoteAndCandles(forInstrument instrument: TinkoffInstrumentModel,
                from: Date,
                to: Date,
                withInterval interval: String,
                then completion: @escaping (Result<InstrumentModelWithQuoteAndCandles>) -> Void) {
    self.getOrderbook(byFIGI: instrument.figi, withDepth: 1) { result in
      switch result {
      case .success(let orderbook):
        self.getCandles(byFIGI: instrument.figi, from: from, to: to, withInterval: interval) { response in
          switch response {
          case .success(let candleModels):
            var modelsToUse: [CandleModelProtocol] = candleModels
            var candles: [Candle] = []
            if modelsToUse.count > self.maxCandlesCount {
              modelsToUse = []
              let firstIndex = candleModels.count - self.maxCandlesCount - 1
              for index in firstIndex...(candleModels.count - 1) {
                modelsToUse.append(candleModels[index])
              }
            }
            for model in modelsToUse {
              let candle = Candle(candleModel: model)
              candles.append(candle)
            }
            let instrumentWithQuote = InstrumentModelWithQuoteAndCandles(instrument: instrument, quote: orderbook.lastPrice, candles: candles)
            completion(.success(instrumentWithQuote))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func getQuotesAndCandles(forInstruments instruments: [TinkoffInstrumentModel],
                           from: Date,
                           to: Date,
                           withInterval interval: String,
                           then completion: @escaping (Result<[InstrumentModelWithQuoteAndCandles]>) -> Void) {
    
    var instrumentsWithQuotes: [InstrumentModelWithQuoteAndCandles] = []
    guard !instruments.isEmpty else {
      completion(.failure(FetchingError.noSuchInstruments))
      return
    }
    for instrument in instruments {
      self.getQuoteAndCandles(forInstrument: instrument, from: from, to: to, withInterval: interval) {result in
        switch result {
        case .success(let instrumentWithQuote):
          instrumentsWithQuotes.append(instrumentWithQuote)
          let instrumentIndex = instruments.firstIndex(of: instrument)
          guard !(instrumentIndex == instruments.count - 1) else {
            completion(.success(instrumentsWithQuotes))
            return
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
    
  }
  
  func getInstrumentsWithQuotesAndCandles(forTicker ticker: String,
                                          from: Date,
                                          to: Date,
                                          withInterval interval: String,
                                          then completion: @escaping (Result<[InstrumentModelWithQuoteAndCandles]>) -> Void) {
    
    var instruments: [TinkoffInstrumentModel] = []
    
    self.getInstrument(byTicker: ticker) { result in
      switch result {
      case .success(let data):
        instruments = data as! [TinkoffInstrumentModel]
        
        self.getQuotesAndCandles(forInstruments: instruments, from: from, to: to, withInterval: interval) { result in
          switch result {
          case .success(let instrumentsAndQuotes):
            guard instrumentsAndQuotes.isEmpty else {
               completion(.success(instrumentsAndQuotes))
               return
             }
            completion(.failure(FetchingError.noSuchInstruments))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
