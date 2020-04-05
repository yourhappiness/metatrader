//
//  AuthCompletedView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 20.02.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct AuthCompletedView: View {
    var body: some View {
      HStack(alignment: .center) {
        Spacer()
        Text("Вы успешно авторизованы.\nДля начала работы перейдите на вкладку \"Торговля\"")
          .multilineTextAlignment(.center)
        Spacer()
      }
    }
}

struct AuthCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthCompletedView()
    }
}
