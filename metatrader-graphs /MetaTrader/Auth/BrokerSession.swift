//
//  BrokerSession.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 15.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

final class BrokerSession {
  
  static let instance = BrokerSession()
  
  private init() {}
  
  public var broker: BrokersList = .none
  public var token: String = ""
  public var isLogined: Bool = false
  public var lastSearch: String = ""
  public var alreadySearched: Bool {
    return self.lastSearch == "" ? false : true
  }
}
