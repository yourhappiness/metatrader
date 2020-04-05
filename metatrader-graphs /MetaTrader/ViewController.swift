//
//  ViewController.swift
//  MetaTrader
//
//  Created by Denis Abramov on 03.12.2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import Cocoa
import SwiftUI

class ViewController: NSViewController {
  
  override func loadView() {
    let view = NSHostingView(rootView: SplitNavigationView())
    self.view = view
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override var representedObject: Any? {
    didSet {
    }
  }
}
