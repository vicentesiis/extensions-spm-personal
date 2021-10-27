//
//  RelaxedValue.swift
//  ClaroVideoServices
//
//  Created by Erick Pulido Cienfuegos on 11/05/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

@propertyWrapper
public struct RelaxedValue<T: LosslessStringConvertible> {
    private var value: T

    public var wrappedValue: T {
        get { return value }
        set { value = newValue }
    }
}

extension RelaxedValue: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self), let value = T(string) {
          self.value = value
        } else if let inte = try? container.decode(Int.self), let value = T(String(inte)){
          self.value = value
        } else {
          throw DecodingError.typeMismatch(String.self, .init(codingPath: decoder.codingPath, debugDescription: ""))
        }
    }

  public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(value)")
    }
}
