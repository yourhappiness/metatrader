//
//  InstrumentModelProtocol.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 16.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation

public protocol InstrumentModelProtocol {
  
  var id: String {get}
  
  var figi: String {get set}
  var ticker: String {get set}
  var lot: Int {get set}
  var currency: String {get set}
  var name: String {get set}
  
}
