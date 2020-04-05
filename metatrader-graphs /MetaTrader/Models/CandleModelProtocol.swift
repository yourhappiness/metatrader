//
//  CandleModelProtocol.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 18.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation

public protocol CandleModelProtocol {
  
  var openingPrice: Double {get set}
  var closingPrice: Double {get set}
  var highestPrice: Double {get set}
  var lowestPrice: Double {get set}
  var time: Date {get set}
  
}
