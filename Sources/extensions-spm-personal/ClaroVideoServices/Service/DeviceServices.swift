//
//  DeviceServices.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 31/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class DeviceServices: CVServiceProtocol {
  
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  public func attach(groupId: String, purchaseId: String?, completion: @escaping (Result<String, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: DeviceRequest.attach(groupId: groupId, purchaseId: purchaseId), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
        let jsonResponse = json["response"] as? [String: Any],
        let attachDictionary = jsonResponse["attach"] as? [String: Any],
        let idString = attachDictionary["id"] as? String {
          completion(.success(idString))
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
