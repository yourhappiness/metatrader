//
//  TinkoffAuthView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 26.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import SwiftUI

struct TinkoffAuthView: View {
    @State private var token: String = ""
    @State private var brokerService = TinkoffService()
    @State private var showingAlert = false
    @State private var alertText: String = ""
    @State var parentView: AuthView
  
    var body: some View {
      VStack {
        Text("Введите токен, полученный у брокера:")
        TextField("", text: $token)
        
        Button(action: {
          self.brokerService.sandboxRegister(forToken: self.token) { result in
            switch result {
            case .success( _):
              self.alertText = "Авторизация прошла успешно"
              BrokerSession.instance.isLogined = true
            case .failure(let error):
              self.alertText = "Произошла ошибка: \(error.localizedDescription)"
            }
            self.showingAlert = true
          }
        }) {
          Text("Войти")
        }
        .alert(isPresented: self.$showingAlert) {
          Alert(title: Text("Результат авторизации"), message: Text(self.alertText), dismissButton: .default(Text("ОК")) {
              self.parentView.brokerSelection = .none
              self.parentView.brokerSelection = .tinkoff
            })
        }
      }
    }
}

struct TinkoffAuthView_Previews: PreviewProvider {
    static var previews: some View {
      TinkoffAuthView(parentView: AuthView())
    }
}
