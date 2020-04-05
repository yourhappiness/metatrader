//
//  Candle.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 18.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

enum CandlesTypes {
  case white
  case black
  case zero
}

struct CandlesSet {
  //отметки на временной оси
  var xTime: [Date] {
    var timeArray = [Date]()
    for candle in self.candles {
      timeArray.append(candle.time)
    }
    return timeArray
  }
  
  //диапазон цен
  var yRange: [Double] {
    var pricesArray = [Double]()
    for candle in self.candles {
      pricesArray.append(contentsOf: [candle.highestPrice, candle.lowestPrice])
    }
    return pricesArray
  }
  
  var candles = [Candle]()
  var lowerBound: Date = NSCalendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
  var upperBound: Date = Date()
}

struct Candle: Identifiable {
  
  var id: Int = 0
  
  var type: CandlesTypes {
    let priceRange = self.closingPrice - self.openingPrice
    if priceRange > 0 {
      return .white
    } else if priceRange < 0 {
      return .black
    } else {
      return .zero
    }
  }
  
  var color: Color {
    switch self.type {
    case .white:
      return .green
    case .black:
      return .red
    case .zero:
      return .black
    }
  }
  
  var candleModel: CandleModelProtocol
  
  var openingPrice: Double {
    return self.candleModel.openingPrice
  }
  var closingPrice: Double {
    return self.candleModel.closingPrice
  }
  var highestPrice: Double {
    return self.candleModel.highestPrice
  }
  var lowestPrice: Double {
    return self.candleModel.lowestPrice
  }
  
  var time: Date {
    return self.candleModel.time
  }
  
  var midPrice: Double {
    return (self.highestPrice - self.lowestPrice) / 2 + self.lowestPrice
  }
  
  //получение значения по оси Y для центра свечи
  func getMidY(minY: Double?, maxY: Double?, screenHeight: CGFloat) -> CGFloat {
    var midY: CGFloat
    guard let maxY = maxY, let minY = minY else {return 0}
    let range = CGFloat(maxY - minY)
    let scale = screenHeight / range
    midY = CGFloat((maxY - self.midPrice)) * scale
    return midY
  }
  
  //получение высоты свечи
  func getHeight(minY: Double?, maxY: Double?, screenHeight: CGFloat) -> CGFloat {
      var height: CGFloat
      guard let minY = minY, let maxY = maxY else {return 0}
      let range = CGFloat(maxY - minY)
      let scale = screenHeight / range
      height = CGFloat(abs(self.highestPrice - self.lowestPrice)) * scale
      return height
  }
}
