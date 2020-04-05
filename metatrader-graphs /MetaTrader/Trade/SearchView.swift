//
//  SearchView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 16.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct SearchView: View {
  
    @State private var brokerService = BrokerSession.instance.broker.brokerService()
  
    @State private var instrumentsQuotesAndCandles: [InstrumentModelWithQuoteAndCandles] = []
  
    @State private var searchText: String = BrokerSession.instance.lastSearch
    @State private var userAlreadySearched: Bool = BrokerSession.instance.alreadySearched
  
    @State private var showingAlert = false

    var candlesSet: CandlesSet = CandlesSet()
    let today = Date()
    var lowerBound: Date {
      return self.candlesSet.lowerBound
    }
  
    private func getInstruments() {
      DispatchQueue.global().async {
                    self.brokerService?.getInstrumentsWithQuotesAndCandles(
                    forTicker: self.searchText,
                    from: self.lowerBound,
                    to: self.today,
                    withInterval: CandleIntervals.hour.descriptionForQuery) { result in
                      switch result {
                      case .success(let instruments):
                          self.instrumentsQuotesAndCandles = instruments
//                        print(instruments)
                      case .failure(let error):
                        print(error.localizedDescription)
                        self.showingAlert = true
                      }
                    }
                  }
    }
    
    var body: some View {
      VStack {
        HStack {
          TextField("Введите тикер инструмента для поиска", text: self.$searchText)
              .textFieldStyle(RoundedBorderTextFieldStyle())
          Button (action: {
            BrokerSession.instance.lastSearch = self.searchText
            self.getInstruments()
            
          }) {
            Text("Найти")
          }
          .alert(isPresented: self.$showingAlert) {
            Alert(title: Text("Инструмент не найден"), message: Text("Проверьте, пожалуйста, корректность ввода тикера"), dismissButton: .default(Text("ОК")) {
                self.showingAlert = false
              })
          }
        }
        if !self.instrumentsQuotesAndCandles.isEmpty {
          HStack(alignment: .top) {
            //используется первый элемент массива, т.к. запросу по тикеру соответствует всегда только один инструмент
            InstrumentView(instrumentAndQuote: self.instrumentsQuotesAndCandles[0])
                .foregroundColor(.black)
                .background(Color.blue)
            GraphView(candlesSet: CandlesSet(candles: self.instrumentsQuotesAndCandles[0].candles))
              .frame(minWidth: 600, maxWidth: 600, minHeight: 550, maxHeight: .infinity)
          }
        } else {
          Spacer()
        }
      }
        //в случае если пользователь уже ранее искал инструмент, показывается результат последнего поиска
      .onAppear() {
        if self.userAlreadySearched {
          self.getInstruments()
        }
      }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
      SearchView()
    }
}
