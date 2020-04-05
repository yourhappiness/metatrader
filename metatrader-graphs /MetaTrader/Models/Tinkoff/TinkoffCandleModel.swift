//
//  TinkoffCandleModel.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 16.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation

enum CandleIntervals: Int, CaseIterable, Identifiable {
  var id: Int {
      return self.rawValue
  }
  
  case oneMinute, twoMinutes, threeMinutes, fiveMinutes, tenMinutes, fifteenMinutes, thirtyMinutes, hour, twoHours, fourHours, day, week, month
  
  var descriptionForQuery: String {
      switch self {
      case .oneMinute: return "1min"
      case .twoMinutes: return "2min"
      case .threeMinutes: return "3min"
      case .fiveMinutes: return "5min"
      case .tenMinutes: return "10min"
      case .fifteenMinutes: return "15min"
      case .thirtyMinutes: return "30min"
      case .hour: return "hour"
      case .twoHours: return "2hour"
      case .fourHours: return "4hour"
      case .day: return "day"
      case .week: return "week"
      case .month: return "month"
      }
  }
  
  var description: String {
      switch self {
      case .oneMinute: return "М1"
      case .twoMinutes: return "M2"
      case .threeMinutes: return "M3"
      case .fiveMinutes: return "M5"
      case .tenMinutes: return "M10"
      case .fifteenMinutes: return "M15"
      case .thirtyMinutes: return "M30"
      case .hour: return "Ч1"
      case .twoHours: return "Ч2"
      case .fourHours: return "Ч4"
      case .day: return "День"
      case .week: return "Неделя"
      case .month: return "Месяц"
      }
  }
}

public struct TinkoffCandleModel: Codable, CandleModelProtocol {
  
  public var figi: String
  public var interval: String
  public var openingPrice: Double
  public var closingPrice: Double
  public var highestPrice: Double
  public var lowestPrice: Double
  public var volume: Int
  public var time: Date
  
  // MARK: - Codable
  
  private enum CodingKeys: String, CodingKey {
      case figi = "figi"
      case interval = "interval"
      case openingPrice = "o"
      case closingPrice = "c"
      case highestPrice = "h"
      case lowestPrice = "l"
      case volume = "v"
      case time = "time"
  }
  
  // MARK: - Init
  
  internal init(figi: String,
                interval: String,
                openingPrice: Double,
                closingPrice: Double,
                highestPrice: Double,
                lowestPrice: Double,
                volume: Int,
                time: String) {
    self.figi = figi
    self.interval = interval
    self.openingPrice = openingPrice
    self.closingPrice = closingPrice
    self.highestPrice = highestPrice
    self.lowestPrice = lowestPrice
    self.volume = volume
    self.time = Formatter.iso8601.date(from: time) ?? Date()
  }
  
}
