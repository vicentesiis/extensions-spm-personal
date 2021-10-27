//
//  Int+Utils.swift
//  ClaroVideoServices
//
//  Created by Oscar Montaño Ayala on 13/09/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public extension Int {
  func spell()->String {
    let number: NSNumber = NSNumber(value: self)
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: number) ?? ""
  }
}
