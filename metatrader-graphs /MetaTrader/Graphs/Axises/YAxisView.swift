//
//  YAxisView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 04.03.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct YAxisView : View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 5, y: 0))
                    path.addLine(to: CGPoint(x: 5, y: geometry.size.height))
                    }
                .stroke(Color.black, lineWidth: 2)
            }
        }
    }
}

struct YAxisView_Previews : PreviewProvider {
    static var previews: some View {
        YAxisView()
            .frame(height: 100)
    }
}
