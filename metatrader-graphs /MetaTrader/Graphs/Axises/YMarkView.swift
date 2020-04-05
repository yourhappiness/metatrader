//
//  YMarkView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 04.03.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct YMarkView: View {
  
    var price: CGFloat
    let offsetForText: CGFloat = 30
  
    var body: some View {
      GeometryReader { geometry in
        VStack (spacing: 0) {
          Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
          }
            .stroke(Color.gray, lineWidth: 1)
          Text(String(format: "%.2f",Double(self.price)))
            .font(.footnote)
            .foregroundColor(.gray)
            .offset(x: (-(geometry.size.width / 2) + self.offsetForText), y: (-geometry.size.height))
        }
        .offset(y: geometry.size.height / 2)
      }
    }
}

struct YMarkView_Previews: PreviewProvider {
    static var previews: some View {
        YMarkView(price: 1700)
          .frame(height: 30, alignment: .leading)
    }
}
