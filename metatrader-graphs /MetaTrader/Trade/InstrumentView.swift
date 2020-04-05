//
//  InstrumentView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 17.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct InstrumentView: View {
  
    let instrumentAndQuote: InstrumentModelWithQuoteAndCandles
  
    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(self.instrumentAndQuote.name).font(.headline)
          Text(self.instrumentAndQuote.ticker).font(.subheadline)
        }
        Spacer()
        Text(String(self.instrumentAndQuote.quote) + " " + self.instrumentAndQuote.currency)
          .italic()
          .font(.headline)
      }
    }
}

