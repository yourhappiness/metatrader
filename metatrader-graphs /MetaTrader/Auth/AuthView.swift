//
//  AuthView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 12.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import SwiftUI

enum BrokersList: Int, CaseIterable, Identifiable {
  var id: Int {
      return self.rawValue
  }
  
  case none
  case tinkoff
  
  var name: String {
    switch self {
    case .tinkoff: return "Тинькофф"
    case .none: return "Брокер не выбран"
    }
  }
  
  func brokerAuthView(parentView: AuthView) -> some View {
    switch self {
    case .tinkoff:
      guard !BrokerSession.instance.isLogined else {
        return AnyView(AuthCompletedView())
      }
      return AnyView(TinkoffAuthView(parentView: parentView))
    case .none:
      return AnyView(BaseAuthView(parentView: parentView))
    }
  }
  
  func brokerService() -> BrokerServiceProtocol? {
    switch self {
    case .tinkoff:
      return TinkoffService()
    case .none:
      return nil
    }
  }
  
}


struct AuthView: View {

  @State var brokerSelection: BrokersList = BrokerSession.instance.broker
    
    var body: some View {
      self.brokerSelection.brokerAuthView(parentView: self)
  }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
