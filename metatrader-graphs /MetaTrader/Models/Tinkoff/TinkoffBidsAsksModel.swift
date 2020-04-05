//
//  TinkoffBidsAsksModel.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 16.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation

public struct TinkoffBidsAsksModel: Codable {
  
  public var price: Double
  public var quantity: Int
  
  // MARK: - Codable
  
  private enum CodingKeys: String, CodingKey {
      case price = "price"
      case quantity = "quantity"
  }
  
  // MARK: - Init
  
  internal init(price: Double, quantity: Int) {
    self.price = price
    self.quantity = quantity
  }
  
}
