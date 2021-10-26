//
//  NetServices.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public final class NetServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }

  //MARK: - Net Services for Brasil
  public func fetchNetOauthCallback(code: String, completion: @escaping(Result<(User, [String: Any]), NetworkError>) -> Void) {
    let fetchNetOauthCallbackRequest = NetRequest.fetchNetOauthCallback(code: code)
    NetworkDispatcher(environment: environment).fetch(request: fetchNetOauthCallbackRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String : AnyObject] {
          let parserResult = User.parseObject(dictionary: response)
          switch parserResult {
          case .success(let user):
            completion(.success((user, response)))
          case .failure(let error):
            completion(.failure(error))
          }
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getNetUrl(completion: @escaping((Result<String, NetworkError>) -> Void)) {
    NetworkDispatcher(environment: environment).fetch(request: NetRequest.getNetUrl, baseParams: baseParameters) { (result) in
      switch (result) {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any],
          let url = response["redirectUrl"] as? String{
          completion(.success(url))
        }else {
          completion(.failure(.errorForParseFailed(error: "Error in parse")))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  public func loginAuthNet(user: String, password: String, completion: @escaping (Result<User,NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: NetRequest.auth(user: user, password: password), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String : AnyObject] {
          let parserResult = User.parseObject(dictionary: response)
          switch parserResult {
          case .success(let user):
            completion(.success(user))
          case .failure(let error):
            completion(.failure(error))
          }
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
  
