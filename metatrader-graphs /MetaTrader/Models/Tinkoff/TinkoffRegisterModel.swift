//
//  TinkoffRegisterModel.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 25.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import Foundation

public struct TinkoffRegisterModel: Codable {
  
  public var trackingID: String
  public var status: String
  
  // MARK: - Codable
  
  private enum CodingKeys: String, CodingKey {
      case trackingID = "trackingId"
      case status = "status"
  }
  
  // MARK: - Init
  
  internal init(trackingId: String, status: String) {
    self.trackingID = trackingId
    self.status = status
  }
  
}
