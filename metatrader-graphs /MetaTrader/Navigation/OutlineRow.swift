//
//  OutlineRow.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 17.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import SwiftUI

struct OutlineRow : View {
    let item: NavigationMenu
    @Binding var selectedMenu: NavigationMenu
    
    var isSelected: Bool {
        selectedMenu == item
    }
    
    var body: some View {
//        HStack {
            Group {
//                Image(item.image)
//                    .scaledToFit()
//                    .foregroundColor(isSelected ? .white : .black)
//            }
//            .frame(width: 40)
            Text(item.title)
                .foregroundColor(isSelected ? .white : .black)
        }
        .padding()
    }
}

struct OutlineRow_Previews : PreviewProvider {
    static var previews: some View {
        OutlineRow(item: .login, selectedMenu: .constant(.login))
    }
}
