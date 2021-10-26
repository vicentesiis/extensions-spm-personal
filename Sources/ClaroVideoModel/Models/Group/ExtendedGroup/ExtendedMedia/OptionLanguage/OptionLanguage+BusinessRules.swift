//
//  OptionLanguage+BusinessRules.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 11/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public extension OptionLanguage {
  
  func isMultipleAudio() -> Bool {
    let stream = self.encodes.filter { (stream) -> Bool in
      return stream == CVStreamType.hlsFairplayMA || stream == CVStreamType.hlsma
    }.first ?? ""
    return !stream.isEmpty
  }
  
}
