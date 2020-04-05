//
//  SplitNavigationView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 17.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import SwiftUI

struct SplitNavigationView: View {
    
    @State var selectedMenu: NavigationMenu = .login
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack() {
                    ForEach(NavigationMenu.allCases) { menu in
                      Group {
                        OutlineRow(item: menu, selectedMenu: self.$selectedMenu)
                        Divider()
                      }
                      .onTapGesture {
                        self.selectedMenu = menu
                      }
                    }
                }
            }
            .frame(width: 200)
            selectedMenu.contentView
      }
      .frame(minWidth: 1200, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
    }
}

struct SplitNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SplitNavigationView()
    }
}
