//
//  NavigationMenu.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 17.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import SwiftUI

enum NavigationMenu: Int, CaseIterable, Identifiable {
    var id: Int {
        return self.rawValue
    }
    
    case demo, login, trading, subscriptionList, settings, reports, tradingSettings, help
    
    var title: String {
        switch self {
        case .demo: return "Создать демо-счет"
        case .login: return "Войти"
        case .trading: return "Торговля"
        case .subscriptionList: return "Подписка"
        case .settings: return "Настройки"
        case .reports: return "Отчеты"
        case .tradingSettings: return "Настройки торговли"
        case .help: return "Помощь"
        }
    }
    
//    var image: String {
//        switch self {
//        case .demo: return ""
//        case .login: return ""
//        case .trading: return ""
//        case .subscriptionList: return ""
//        case .settings: return ""
//        case .reports: return ""
//        case .tradingSettings: return ""
//        case .help: return ""
//        }
//    }

    var contentView: some View {
        switch self {
        case .demo: return AnyView( NavigationView{ Rectangle() })
        case .login: return AnyView( AuthView())
        case .trading:
          if BrokerSession.instance.isLogined {
            return AnyView( SearchView())
          } else {
            return AnyView( Rectangle())
          }
        case .subscriptionList: return AnyView( NavigationView{ Rectangle() })
        case .settings: return AnyView( NavigationView{ Rectangle() })
        case .reports: return AnyView( Rectangle() )
        case .tradingSettings: return AnyView( Rectangle() )
        case .help: return AnyView( Rectangle() )
        }
    }
}
