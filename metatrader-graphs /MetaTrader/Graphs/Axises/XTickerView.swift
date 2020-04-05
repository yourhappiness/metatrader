//
//  XTickerView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 04.03.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct XTickerView: View {
  
    let padding: CGFloat
    var doublePadding: CGFloat {
      return self.padding * 2
    }
  
    var candlesSet: CandlesSet
  
    var xTime: [Date] {
      return self.candlesSet.xTime
    }
  
    var estimatedMarksNumber: Double {
      return Double(self.candlesSet.candles.count - 1) / 4 + 1 //12
    }
  
    let axisHeight: CGFloat = 42
  
    var body: some View {
      GeometryReader { geometry in
        HStack (spacing: 0) {
          ForEach(self.calculateIndexes(), id: \.self) { indexMark in
            TimeMarkView(index: indexMark, xTime: self.xTime)
          }
          .frame(width: (geometry.size.width - self.doublePadding) / CGFloat(self.estimatedMarksNumber - 1), height: self.axisHeight)
        }
        .frame(width: geometry.size.width - self.doublePadding)
      }
      .overlay(XAxisView())
      .opacity(0.7)
    }
  
    private func calculateIndexes() -> [Int] {
        let indexes: [Int] = Array(0 ..< self.xTime.count).filter{$0 % 4 == 0}
        return indexes
    }
}

struct XTickerView_Previews: PreviewProvider {
    static var previews: some View {
        XTickerView(padding: 10,
                    candlesSet: CandlesSet(candles: [
          Candle(candleModel:
            TinkoffCandleModel(figi: "",
                               interval: "",
                               openingPrice: 120,
                               closingPrice: 150,
                               highestPrice: 165,
                               lowestPrice: 115,
                               volume: 20,
                               time: "2020-02-14T18:38:33.131642+03:00")),
          Candle(candleModel:
            TinkoffCandleModel(figi: "",
                               interval: "",
                               openingPrice: 140,
                               closingPrice: 120,
                               highestPrice: 165,
                               lowestPrice: 120,
                               volume: 20,
                               time: "2020-02-16T18:38:33.131642+03:00"))]))
    }
}
