//
//  TinkoffNetworkService.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 17.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Alamofire

final class TinkoffNetworkService {
  internal let networkManager = NetworkManager()
  internal let decoder = JSONDecoder()
  internal let baseUrl = "https://api-invest.tinkoff.ru/openapi"
  
  private enum Resource: String {
    case sandbox = "/sandbox"
    case portfolio = "/portfolio"
    case market = "/market"
  }
  
  private struct Headers {
    static let auth = "Authorization"
  }
  
  func sandboxRegister(forToken token: String, then completion: @escaping (Result<TinkoffRegisterModel>) -> Void) {
      let parameters: Parameters = [:]
      let url = baseUrl + Resource.sandbox.rawValue + "/sandbox/register"
      var headers: HTTPHeaders = [:]
      headers[Headers.auth] = "Bearer " + token
      
      let request = WebRequest(method: .post, url: url, parameters: parameters, headers: headers)
      
      networkManager.jsonRequest(request) { [weak self] result in
          guard let self = self else { return }
          result
              .withValue { response in
                  do {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    guard let data = jsonString?.data(using: .utf8) else {return}
                    let result = try self.decoder.decode(TinkoffRegisterModel.self, from: data)
                    completion(.success(result))
                  } catch {
                    print(error)
                    completion(.failure(error))
                  }
              }
              .withError { error in
                completion(.failure(error))
              }
      }
  }
  
  func getInstrument(byTicker ticker: String,
                     then completion: @escaping (Result<[InstrumentModelProtocol]>) -> Void) {
    var parameters: Parameters = [:]
    parameters["ticker"] = ticker
    let url = baseUrl + Resource.market.rawValue + "/search/by-ticker"
    var headers: HTTPHeaders = [:]
    headers[Headers.auth] = "Bearer " + BrokerSession.instance.token
    
    let request = WebRequest(method: .get, url: url, parameters: parameters, headers: headers)
    
    networkManager.jsonRequest(request) { [weak self] result in
        guard let self = self else { return }
        result
            .withValue { response in
                do {
                  let responseDictionary: [String : Any] = response
                  guard let responseBody: [String : Any] = responseDictionary["payload"] as? [String : Any] else {
                    completion(.failure(FetchingError.noSuchInstruments))
                    return
                  }
                  let instruments = responseBody["instruments"]
                  let jsonData = try JSONSerialization.data(withJSONObject: instruments as Any, options: .prettyPrinted)
                  let jsonString = String(data: jsonData, encoding: .utf8)
                  guard let data = jsonString?.data(using: .utf8) else {return}
                  let result = try self.decoder.decode([TinkoffInstrumentModel].self, from: data)
                  completion(.success(result))
                } catch {
                  print(error)
                  completion(.failure(error))
                }
            }
            .withError { error in
              completion(.failure(error))
            }
    }
  }
  
  func getOrderbook(byFIGI figi: String,
                    withDepth depth: Int,
                    then completion: @escaping (Result<TinkoffOrderbookModel>) -> Void) {
    var parameters: Parameters = [:]
    parameters["figi"] = figi
    parameters["depth"] = depth
    let url = baseUrl + Resource.market.rawValue + "/orderbook"
    var headers: HTTPHeaders = [:]
    headers[Headers.auth] = "Bearer " + BrokerSession.instance.token
    
    let request = WebRequest(method: .get, url: url, parameters: parameters, headers: headers)
    
    networkManager.jsonRequest(request) { [weak self] result in
        guard let self = self else { return }
        result
            .withValue { response in
                do {
                  let responseDictionary: [String : Any] = response
                  guard let responseBody: [String : Any] = responseDictionary["payload"] as? [String : Any] else {return}
                  let jsonData = try JSONSerialization.data(withJSONObject: responseBody as Any, options: .prettyPrinted)
                  let jsonString = String(data: jsonData, encoding: .utf8)
                  guard let data = jsonString?.data(using: .utf8) else {return}
                  let result = try self.decoder.decode(TinkoffOrderbookModel.self, from: data)
                  completion(.success(result))
                } catch {
                  print(error)
                  completion(.failure(error))
                }
            }
            .withError { error in
              completion(.failure(error))
            }
    }
  }
  
  func getCandles(byFIGI figi: String,
                  from: Date,
                  to: Date,
                  withInterval interval: String,
                  then completion: @escaping (Result<[CandleModelProtocol]>) -> Void) {
    var parameters: Parameters = [:]
    let fromString = from.iso8601
    let toString = to.iso8601
    parameters["figi"] = figi
    parameters["from"] = fromString
    parameters["to"] = toString
    parameters["interval"] = interval
    let url = baseUrl + Resource.market.rawValue + "/candles"
    var headers: HTTPHeaders = [:]
    headers[Headers.auth] = "Bearer " + BrokerSession.instance.token
    
    let request = WebRequest(method: .get, url: url, parameters: parameters, headers: headers)
    
    self.decoder.dateDecodingStrategy = .iso8601
    
    networkManager.jsonRequest(request) { [weak self] result in
        guard let self = self else { return }
        result
            .withValue { response in
                do {
                  let responseDictionary: [String : Any] = response
                  guard let responseBody: [String : Any] = responseDictionary["payload"] as? [String : Any] else {return}
                  let candles = responseBody["candles"]
                  let jsonData = try JSONSerialization.data(withJSONObject: candles as Any, options: .prettyPrinted)
                  let jsonString = String(data: jsonData, encoding: .utf8)
                  guard let data = jsonString?.data(using: .utf8) else {return}
                  let result = try self.decoder.decode([TinkoffCandleModel].self, from: data)
                  completion(.success(result))
                } catch {
                  print(error)
                  completion(.failure(error))
                }
            }
            .withError { error in
              completion(.failure(error))
            }
    }
  }
}

