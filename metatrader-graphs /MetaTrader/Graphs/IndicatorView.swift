//
//  IndicatorView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 26.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct IndicatorView: View {
  
    @State private var positionIndicator: CGFloat = 0.0
    @State private var translation: CGFloat = 0
    @State private var minTranslation: CGFloat = 0
    @State private var setPoint: CGFloat = 0
  
    let padding: CGFloat
    var doublePadding: CGFloat {
      return self.padding * 2
    }
    let paddinForInfoTable: CGFloat = 10
    let cornerRadiusForInfoTable: CGFloat = 15
    let offsetForInfoTable: CGFloat = 68
          
    var candlesSet: CandlesSet
  
    var candles: [Candle] {
      return self.candlesSet.candles
    }
  
    var xTime: [Date] {
      return self.candlesSet.xTime
    }
    
    private var indexIndicator: Int {
      guard round(self.translation) >= round(self.minTranslation), self.minTranslation > 0 else {return 0}
      let index = Int(round(self.translation / self.minTranslation))
      guard index < self.candles.count else {
        return self.candles.count - 1
      }
      return index
    }
  
    var dateFormatter: DateFormatter {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd MMM y HH:mm"
      return formatter
    }
  
    var body: some View {
      GeometryReader { geometry in
        ZStack {
          //информационный прямоугольник
            VStack {
              Text(self.dateFormatter.string(from: self.xTime[self.indexIndicator]))
                .multilineTextAlignment(.center)
              HStack {
                VStack(alignment: .leading) {
                  Text("Откр.")
                  Text("Закр.")
                  Text("Макс.")
                  Text("Мин.")
                }
                VStack(alignment: .trailing) {
                  Text("\(String(format: "%.3f", self.candles[self.indexIndicator].openingPrice))Р")
                  Text("\(String(format: "%.3f", self.candles[self.indexIndicator].closingPrice))Р")
                  Text("\(String(format: "%.3f", self.candles[self.indexIndicator].highestPrice))Р")
                  Text("\(String(format: "%.3f", self.candles[self.indexIndicator].lowestPrice))Р")
                }
              }
            }
            .padding(self.paddinForInfoTable)
            .background(Color.black)
            .opacity(0.7)
            .cornerRadius(self.cornerRadiusForInfoTable)
            .offset(x: self.positionIndicator < 0.6 ?
              -geometry.size.width / 2 + self.offsetForInfoTable :
              -self.offsetForInfoTable - geometry.size.width / 2 )
          //линия
          Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
          }
          .stroke(Color.black, lineWidth: 2)
        }
        .frame(height: geometry.size.height)
        .offset(x: self.positionIndicator * (geometry.size.width - self.doublePadding) + self.padding)
        .gesture(DragGesture()
          .onChanged { value in
            let screenWidth = geometry.size.width - self.doublePadding
            self.minTranslation = screenWidth / CGFloat(self.candles.count - 1)
            var factualTranslation = value.translation.width + self.setPoint
            if factualTranslation > screenWidth {
              factualTranslation = screenWidth
            }
            let translationToNearestCandle = round(factualTranslation / CGFloat(self.minTranslation)) * CGFloat(self.minTranslation)
            
            let newPosition = (translationToNearestCandle / screenWidth)
            self.positionIndicator = min(max(newPosition,0),1)
            self.translation = self.positionIndicator * screenWidth
          }
          .onEnded {_ in
            self.setPoint = self.positionIndicator * (geometry.size.width - self.doublePadding)
          }
        )
      }
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView(padding: 10,
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
