//
//  String+Error.swift
//  Clarovideo
//
//  Created by Lech H. Conde on 01/03/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

extension String: Error {}

extension String: LocalizedError {
  public var errorDescription: String? { return self }
}
