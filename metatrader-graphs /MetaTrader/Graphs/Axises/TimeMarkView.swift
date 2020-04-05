//
//  TimeMarkView.swift
//  MetaTrader
//
//  Created by Anastasia Romanova on 03.03.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import SwiftUI

struct TimeMarkView: View {
  
    var index: Int
    var xTime: [Date]
    var dateFormatter: DateFormatter {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd MMM"
      return formatter
    }
  
    var timeFormatter: DateFormatter {
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      return formatter
    }
  
    let markHeight: CGFloat = 10
    
    var body: some View {
      GeometryReader { geometry in
        VStack (spacing: 0) {
          Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: self.markHeight))
          }
            .stroke(Color.black)
          Text(verbatim: String(self.dateFormatter.string(from: self.xTime[self.index])))
            .font(.footnote)
            .offset(x: (-(geometry.size.width / 2)))
            .foregroundColor(.black)
          Text(verbatim: String(self.timeFormatter.string(from: self.xTime[self.index])))
            .font(.footnote)
            .offset(x: (-(geometry.size.width / 2)))
            .foregroundColor(.black)
        }
        .offset(x: geometry.size.width / 2)
      }
    }
}

struct TimeMarkView_Previews: PreviewProvider {
    static var previews: some View {
      TimeMarkView(index: 0, xTime: [String("2020-02-16T18:38:33.131642+03:00").iso8601!])
      .frame(width: 45, height: 42)
      .padding(40)
    }
}
