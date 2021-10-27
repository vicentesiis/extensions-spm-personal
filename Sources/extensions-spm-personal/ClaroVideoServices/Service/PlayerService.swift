//
//  PlayerService.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class PlayerServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Service methods
  public func getMedia(params: GetMediaParams, completion: @escaping (Result<PlayerMedia, NetworkError>) -> Void) {
    let playerMediaRequest = PlayerRequest.getMedia(getMediaParams: params)
    NetworkDispatcher(environment: environment).fetch(request: playerMediaRequest, baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let response = json["response"] as? [String: Any], !response.isEmpty {
          let parserResult = PlayerMedia.parseObject(dictionary: response as [String : AnyObject])
          switch parserResult {
          case .success(let playerMedia):
            if let entity = json["entry"] as? [String: Any] {
              if let streamType = entity["stream_type"] as? String {
                playerMedia.streamType = streamType
              }
              if let contentId = entity["content_id"] as? String {
                playerMedia.contentId = contentId
              }
              if let preview = entity["preview"] as? String {
                playerMedia.isTrailer = preview
              }
            }
            playerMedia.httpHeaders = playerMediaRequest.headers
            completion(.success(playerMedia))
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
  
  public func getQualities(url: String, language: String, completion: @escaping (Result<[Quality], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(uri:url, request: PlayerRequest.getQualities(language: language), baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let responceData = response.data,
          let content = try? JSONSerialization.jsonObject(with: responceData, options: []),
          let data = content as? [Any] {
          let parserResult = ParserHelper.parseObject(of: [Quality].self, data: data)
          switch parserResult {
          case .success(let qualities):
            completion(.success(qualities))
          case .failure(let error):
            completion(.failure(error))
          }
        } else {
          completion(.success([]))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func sendTrackEvent(withURI uri: String, completion: @escaping (Result<[String:Any], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(uri: uri,
      request: PlayerRequest.sendTrackEvent,
      baseParams: baseParameters) { result in
        switch result {
        case .success(let response):
          if let json = response.jsonData,
            let response = json["response"] as? [String: Any] {
            completion(.success(response))
          } else {
            completion(.success([:]))
          }
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
  
  public func sendDashboardEvent(withURI uri: String, completion: @escaping (Result<[String:Any], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(uri: uri,  request: PlayerRequest.sendClaroDashboardEvent,
    baseParams: baseParameters) { result in
        switch result {
        case .success(let response):
          if let json = response.jsonData,
            let response = json["response"] as? [String: Any] {
            completion(.success(response))
          }
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
  
  public func getCkc(withURI uri:String, completion: @escaping (Result<Data?, NetworkError>) -> Void) ->  URLSessionDataTask? {
   return NetworkDispatcher(environment: environment).fetchSync(uri: uri, request: PlayerRequest.getCkc, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        completion(.success(response.data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getUrlRequest(for uri: String, method: String, parameters: [String: Any], useJsonFormat: Bool = false) -> URLRequest? {
    let requestMethod: HTTPMethod = method.lowercased() == "get" ? .get : .post
    let headers = useJsonFormat ? ["Content-Type": "application/json"] : ["Content-Type":"application/x-www-form-urlencoded","Accept-Language": "es-MX;q=1, en-MX;q=0.9"]
    let simpleRequest = SimpleRequest(path: "", method: requestMethod, headers: headers, timeoutInterval: 10)
    return NetworkDispatcher(environment: environment).getUrlRequest(for: uri, request: simpleRequest, parameters: parameters)
  }
}
