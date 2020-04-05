//
//  BaseAuthView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 21.01.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct BaseAuthView: View {
    @State var brokerSelection: BrokersList = .none
    @State var parentView: AuthView
  
    var body: some View {
      VStack {
        Text("Имя компании или сервер брокера:")
        
        Picker(selection: self.$brokerSelection, label: Text("Имя компании или сервер брокера:")) {
          ForEach(BrokersList.allCases, id: \.self) { broker in
            Text(broker.name).tag(broker.id)
          }
        }
        .labelsHidden()
        
        Button(action: {
          BrokerSession.instance.broker = self.brokerSelection
          self.parentView.brokerSelection = self.brokerSelection
        }) {
          Text("Выбрать")
        }
      }
    }
  }

struct BaseAuthView_Previews: PreviewProvider {
    static var previews: some View {
      BaseAuthView(parentView: AuthView())
    }
}
