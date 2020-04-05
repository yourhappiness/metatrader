//
//  Date+ext.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 18.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation

extension Date {
  func dateToInt() -> Int {
    var intDate: Int
    let interval = self.timeIntervalSince1970
    intDate = Int(interval)
    return intDate
  }
}
