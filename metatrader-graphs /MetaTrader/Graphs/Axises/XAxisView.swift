//
//  XAxisView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 03.03.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct XAxisView: View {
    var body: some View {
        VStack {
          GeometryReader { geometry in
            Path { path in
                  path.move(to: CGPoint(x: 0, y: 0))
                  path.addLine(to: CGPoint(x:geometry.size.width , y: 0))
                }
              .stroke(Color.black, lineWidth: 2)
          }
        }
    }
}

struct XAxisView_Previews: PreviewProvider {
    static var previews: some View {
        XAxisView()
          .frame(height: 30)
    }
}
