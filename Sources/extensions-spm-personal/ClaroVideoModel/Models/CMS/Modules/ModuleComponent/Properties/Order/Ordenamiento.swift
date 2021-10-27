//
//  Ordenamiento.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 17/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

final public class Ordenamiento: NSObject {
  
  public var label: String?
  public var order: String?
  
  public override init() {
    self.label = nil
    self.order = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let labelDecode = try? container.decode(String.self, forKey: .label) {
      label = String(htmlEncodedString: labelDecode) ?? ""
    }
    if let orderDecode = try? container.decode(String.self, forKey: .order) {
      order = orderDecode
    }
  }
}
