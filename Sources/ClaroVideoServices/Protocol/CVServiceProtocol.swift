//
//  CVServiceProtocol.swift
//  ClaroVideoServices
//
//  Created by alonso.salcido on 26/09/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public protocol CVServiceProtocol {
  var environment: Environment { get set }
  var baseParameters: ServiceParameters? { get set }
  init(environment: Environment, baseParameters: ServiceParameters?)
}
