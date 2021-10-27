//
//  CMSService.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/31/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class CMSServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Service methods
  public func getLevel(node: String, completion: @escaping (Result<[Module], NetworkError>) -> Void) {
    moduleRequest(CMSRequest.level(node: node), completion: completion)
  }
  
  public func getLevelUser(node: String, completion: @escaping (Result<[Module], NetworkError>) -> Void) {
    moduleRequest(CMSRequest.levelUser(node: node), completion: completion)
  }
  
  public func getSpecial(special: String, completion: @escaping (Result<[Module], NetworkError>) -> Void) {
    moduleRequest(CMSRequest.special(specialName: special), completion: completion)
  }
  
  public func getSuperhighlight(path: String, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: CMSRequest.superhighlight(path: path), baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any],
          let highlight = response["highlight"] {
          let parserResult = ParserHelper.parseObject(of: [Group].self, data: highlight)
          switch parserResult {
          case .success(let groups):
            completion(.success(groups))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  //MARK: - Private functions
  fileprivate func moduleRequest(_ request: CMSRequest, completion: @escaping (Result<[Module], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any],
          let modules = response["modules"] as? [String: Any] {
          let parserResult = Modules.parseObject(dictionary: modules as [String : AnyObject])
          switch parserResult {
          case .success(let modules):
            completion(.success(modules.module))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

