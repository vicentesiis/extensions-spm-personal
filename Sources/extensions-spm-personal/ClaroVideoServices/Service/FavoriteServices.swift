//
//  FavoriteServices.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public final class FavoriteServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Favorite Services
  public func getLiveFavorited(epgVersion: String,completion: @escaping (Result<[EPGChannel], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: FavoriteRequest.favoriteLive(epgVersion: epgVersion), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let jsonResponse = json["response"] as? [String: Any],
          let jsonChannels = jsonResponse["channels"] as? [[String: Any]] {
          
          let filterChannels = jsonChannels.filter({$0["group"] != nil})
          let epgChannel = ParserHelper.parseSimpleObject(of: [EPGChannel].self, data: filterChannels)
          completion(.success(epgChannel ?? []))
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getFavorited(path: String, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    let request = FavoriteRequest.favorited(path: path)
    NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { result in
    switch result {
      case .success(let response):
        if let json = response.jsonData,
            let response = json["response"] as? [String: Any],
                let groups = response["groups"] {
          let parserResult = ParserHelper.parseObject(of: [Group].self, data: groups)
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
  
  public func add(groupId: String, completion: @escaping (Result<String?, NetworkError>) -> Void) {
    let favoriteAddRequest = FavoriteRequest.add(groupId: groupId)
    favoriteAction(request: favoriteAddRequest, completion: completion)
  }
  
  public func delete(groupId: String, completion: @escaping (Result<String?, NetworkError>) -> Void) {
    let favoriteDeleteRequest = FavoriteRequest.delete(groupId: groupId)
    favoriteAction(request: favoriteDeleteRequest, completion: completion)
  }
  
  fileprivate func favoriteAction(request: FavoriteRequest, completion: @escaping (Result<String?, NetworkError>) -> Void) {
    
    NetworkDispatcher(environment: environment).fetch(request:request, baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        guard let json = response.jsonData,
              let lasttouchDic = json["lasttouch"] as? [String: Any],
              let lasttouch = lasttouchDic["favorited"] as? String else {
          completion(.success(nil))
          return
        }
        completion(.success(lasttouch))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
