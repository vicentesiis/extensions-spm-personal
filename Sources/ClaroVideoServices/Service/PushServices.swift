//
//  PushServices.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 04/02/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

final public class PushServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Service methods
  public func addToken(params: RemoteNotificationData, completion: @escaping (Result<[String:Any], NetworkError>) -> Void) {
    let addTokenRequest = PushNotificationRequest.addToken(notificationData: params)
    NetworkDispatcher(environment: environment).fetch(request: addTokenRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let jsonResponce = response.jsonData {
          completion(.success(jsonResponce))
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func deleteToken(params: RemoteNotificationData, completion: @escaping (Result<[String:Any], NetworkError>) -> Void) {
    let deleteTokenRequest = PushNotificationRequest.deleteToken(notificationData: params)
    NetworkDispatcher(environment: environment).fetch(request: deleteTokenRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let jsonResponce = response.jsonData {
          completion(.success(jsonResponce))
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
