//
//  CandleView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 18.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct CandleView: View {
  
    var candle: Candle
    var lineWidth: CGFloat = 1
    var width: CGFloat = 4
    //высота свечи
    var height: CGFloat
    //высота прямоугольника в составе свечи (диапазон цен открытия и закрытия)
    var rectangleHeight: CGFloat {
      let height = CGFloat(abs(self.candle.closingPrice - self.candle.openingPrice)) * self.scale
      //для отражения штриха цены на свечах с нулевой разницей в изменении цены
      guard height != 0 else {return 2}
      return height
    }
    
    var scale: CGFloat {
      return self.height / CGFloat(self.candle.highestPrice - self.candle.lowestPrice)
    }
    //высота линии в составе свечи (диапазон минимальной и максимальной цен)
    var lineHeight: CGFloat {
      return self.height
    }
  
    var rectangleMinY: CGFloat {
      return CGFloat(min(self.candle.openingPrice, self.candle.closingPrice))
    }
    //расстояние, на которое должен быть смещен прямоугольник относительно нижней точки свечи
    var offsetY: CGFloat {
      return (self.rectangleMinY - CGFloat(self.candle.lowestPrice)) * scale
    }
  
    var body: some View {
      ZStack {
        //линия
        Rectangle()
          .fill(self.candle.color)
          .frame(width: self.lineWidth, height: self.lineHeight)
          .position(x: self.width / 2, y: self.height / 2)
        //прямоугольник
        Rectangle()
          .fill(self.candle.color)
          .frame(width: self.width,
                 height: self.rectangleHeight)
          .position(x: self.width / 2, y: self.lineHeight - self.rectangleHeight / 2 - self.offsetY)
      }
      .frame(width: self.width, height: self.height, alignment: .center)
      .offset(x: self.width / 2)
    }
}

struct CandleView_Previews: PreviewProvider {
    static var previews: some View {
      CandleView(candle: Candle(candleModel:
        TinkoffCandleModel(figi: "",
                         interval: "",
                         openingPrice: 1708,
                         closingPrice: 1710,
                         highestPrice: 1712,
                         lowestPrice: 1704,
                         volume: 20,
                         time: "2019-08-19T18:38:33.131642+03:00")), height: 200)
    }
}
