//
//  YTickerView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 04.03.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct YTickerView: View {
  
    let padding: CGFloat
    var doublePadding: CGFloat {
      return self.padding * 2
    }
  
    var marksNumber = 10
  
    var candlesSet: CandlesSet
  
    var yValues: [Double] {
      return self.candlesSet.yRange
    }
  
    private var minY: CGFloat {
      guard let minY = self.yValues.min() else { return 0}
      return CGFloat(minY)
    }
  
    private var maxY: CGFloat {
      guard let maxY = self.yValues.max() else { return 0}
      return CGFloat(maxY)
    }
  
    private var rangeY: CGFloat {
      return self.maxY - self.minY
    }
  
    var body: some View {
      GeometryReader { geometry in
        VStack (spacing: 0) {
          ForEach(self.calcScale(height: geometry.size.height - self.doublePadding).marks.reversed(), id: \.self) { mark in
            YMarkView(price: mark)
          }
          .frame(width: geometry.size.width, height: self.calcScale(height: geometry.size.height - self.doublePadding).stepYHeight, alignment: .leading)
        }
      }
      .overlay(YAxisView())
      .opacity(0.7)
    }
  
    private func calcScale(height: CGFloat) -> (stepYHeight: CGFloat, marks: [CGFloat]) {
      let scaleY: CGFloat = height / CGFloat(self.rangeY)
      let stepYHeight: CGFloat = height / CGFloat(self.marksNumber - 1)
      let stepYValue: CGFloat = stepYHeight / scaleY
      var marks = [CGFloat]()
      for index in 0 ..< self.marksNumber {
        marks.append(self.minY + stepYValue * CGFloat(index))
      }
      
      return (stepYHeight: stepYHeight, marks: marks)
    }
}

struct YTickerView_Previews: PreviewProvider {
    static var previews: some View {
      YTickerView(padding: 10,
                  candlesSet:
        CandlesSet(candles: [
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
