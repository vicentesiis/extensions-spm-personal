//
//  MusicMiddlewareServices.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 30/07/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class MusicMiddlewareServices: CVServiceProtocol {
 
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: -Init
  public init(environment enviroment: Environment, baseParameters: ServiceParameters?) {
    self.environment = enviroment
    self.baseParameters = baseParameters
  }
  
  public func isLoggedin(email: String, completion: @escaping(Result<[String: Any], NetworkError>)->Void) {
    let loginRequest = MusicMiddlewareRequest.isLoggedin(email: email)
    NetworkDispatcher(environment: environment).fetch(request: loginRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData,
          let hasBusinessNotError = jsonData["success"] as? Bool,
          hasBusinessNotError,
          let responseDic = jsonData["response"] as? [String: Any] else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        completion(.success(responseDic))
        return
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func musicLevel(completion: @escaping(Result<[MusicComponent], NetworkError>)->Void) {
    let musicLevelRequest = MusicMiddlewareRequest.musicLevel
    NetworkDispatcher(environment: environment).fetch(request: musicLevelRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonDic = response.jsonData,
          let responseDic = jsonDic["response"] as? [String: Any],
          let component = responseDic["components"] as? [[String: Any]] else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        let musicComponent = MusicComponent.deserializeResponse(jsonDictionary: component)
        completion(.success(musicComponent))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func cmsRibbon(completion: @escaping(Result<[MusicComponent], NetworkError>)->Void) {
    let ribbonRequest = MusicMiddlewareRequest.ribbon
    NetworkDispatcher(environment: environment).fetch(request: ribbonRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonDic = response.jsonData,
          let responseDic = jsonDic["response"] as? [String: Any],
          let component = responseDic["components"] as? [[String: Any]] else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        let musicComponent = MusicComponent.deserializeResponse(jsonDictionary: component)
        completion(.success(musicComponent))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getPlaylistDetailWithUri(uri: String, completion: @escaping(Result<[MusicComponent], NetworkError>)->Void) {
    let getPlayListDetailRequest = MusicMiddlewareRequest.getPlaylistDetailWithUri
    NetworkDispatcher(environment: environment).fetch(uri: uri, request: getPlayListDetailRequest, baseParams: baseParameters, completion: { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData,
          let hasBusinessNotError = jsonData["success"] as? Bool,
          let responseDic = jsonData["response"] as? [String: Any],
          let components = responseDic["components"] as? [[String: Any]],
          hasBusinessNotError else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        let musicComponent = MusicComponent.deserializeResponse(jsonDictionary: components)
        completion(.success(musicComponent))
        break
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  public func getPlayerWith(uri: String, mediasOnly: Bool, completion: @escaping(Result<[MusicComponent], NetworkError>)->Void) {
    let getPlayerRequest = MusicMiddlewareRequest.getPlayerWith(mediasOnly: mediasOnly)
    NetworkDispatcher(environment: environment).fetch(uri: uri, request: getPlayerRequest, baseParams: baseParameters, completion: { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData,
          let hasBusinessNotError = jsonData["success"] as? Bool,
          let responseDic = jsonData["response"] as? [String: Any],
          let components = responseDic["components"] as? [[String: Any]],
          hasBusinessNotError  else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        let musicComponent = MusicComponent.deserializeResponse(jsonDictionary: components)
        completion(.success(musicComponent))
        break
      case .failure(let error):
        completion(.failure(error))
        break
      }
    })
  }
  
  public func playerGetMediaWith(listId: String, track: String, completion: @escaping(Result<MusicMedia, NetworkError>)->Void) {
    let playerGetMediaRequest = MusicMiddlewareRequest.playerGetMediaWith(listId: listId, track: track)
    NetworkDispatcher(environment: environment).fetch(request: playerGetMediaRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        let responceKey = String(format: "%@-%@", track, listId)
        guard let jsonData = response.jsonData,
          let hasBusinessNotError = jsonData["success"] as? Bool,
          hasBusinessNotError,
          let responseDic = jsonData["response"] as? [String: Any],
          let responceMedia = responseDic[responceKey] as? [String: Any] else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        let musicMediaParse = MusicMedia.parseObject(dictionary: responceMedia)
        switch musicMediaParse {
        case .success(let musicMedia):
          completion(.success(musicMedia))
          break
        case .failure(let error):
          completion(.failure(error))
          break
        }
        
        break
      case .failure(let error):
        completion(.failure(error))
        break
      }
    }
  }
  
  public func sendTrackEvent(uri: String, params: [String: Any]?, completion: @escaping(Result<Bool, NetworkError>)->Void) {
    var trackRequest: MusicMiddlewareRequest = .sendTrackEventWith
    if let trackParams = params {
      trackRequest = .sendSuccessTrackWith(params: trackParams)
    }
    NetworkDispatcher(environment: environment).fetch(uri: uri, request: trackRequest, baseParams: baseParameters, completion: { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData,
          let hasBusinessNotError = jsonData["success"] as? Bool else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        completion(.success(hasBusinessNotError))
      case .failure(let error):
        completion(.failure(error))
        break
      }
    })
  }
}
