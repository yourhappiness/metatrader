//
//  GraphView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 30.01.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct GraphView: View {
  
    let padding: CGFloat = 50
    var doublePadding: CGFloat {
      return self.padding * 2
    }
  
    var xTime: [Date] {
      return self.candlesSet.xTime
    }
    var candlesSet: CandlesSet
    var candles: [Candle] {
      return self.candlesSet.candles
    }
    var yValues: [Double] {
      return self.candlesSet.yRange
    }
  
    private var minY: Double? {
      self.yValues.min()
    }
    private var maxY: Double? {
      self.yValues.max()
    }
    private var rangeY: Double {
      return (self.maxY ?? 0) - (self.minY ?? 0)
    }

    var body: some View {
      GeometryReader { geometry in
        ZStack {
          VStack {
            HStack {
              //свечи
              ForEach(0 ..< self.candles.count, id: \.self) { index in
                CandleView(candle: self.candles[index],
                           height: self.candles[index].getHeight(minY: self.minY,
                                                                 maxY: self.maxY, screenHeight: geometry.size.height - self.doublePadding))
                  .position(y: self.candles[index].getMidY(minY: self.minY,
                                                           maxY: self.maxY,
                                                           screenHeight: geometry.size.height - self.doublePadding) + self.padding)
              }
            }
            .padding([.horizontal], self.padding)
            //ось Х
            XTickerView(padding: self.padding, candlesSet: self.candlesSet)
              .frame(height: 42)
          }
          .background(Color.white)
          //ось Y
          YTickerView(padding: self.padding, candlesSet: self.candlesSet)
          //бегунок со значениями
          IndicatorView(padding: self.padding, candlesSet: self.candlesSet)
        }
      }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(candlesSet: CandlesSet(candles: [
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

