//
//  RecordingService.swift
//  ClaroVideoServices
//
//  Created by alonso.salcido on 11/16/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

public final class RecordingService: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  
  //MARK: Service methods
  
  //Add recording
  public func addRecordingEvent(eventId:String, channelId: String, paywayToken: String, offset: Int?, completion: @escaping (Result<[String: Any],NetworkError>) -> Void) {
    let addEventRequest = RecordingRequest.addRecordingEventRequest(eventId: eventId, channelId: channelId, paywayToken: paywayToken, offset: offset)
    NetworkDispatcher(environment: environment).fetch(request: addEventRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData, let responseObj = jsonData["response"] as? [String: Any], let status = responseObj["status"] as? String, status != "ERROR" else {
          completion(.failure(NetworkError.errorForWrongStructure()))
          return
        }
        completion(.success(responseObj))
        break
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  //Get recording list with status
  public func getRecordingList(status: String,completion: @escaping (Result<RecordingListResponse, NetworkError>) -> Void) {
    let getRecordingListRequest = RecordingRequest.getRecordingListWithStatusRequest(status: status)
    NetworkDispatcher(environment: environment).fetch(request: getRecordingListRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData,
              let status = jsonData["status"] as? Int,
              status == 200,
              let response = jsonData["response"] as? [String: Any] else {
          completion(.failure(NetworkError.errorForWrongStructure()))
          return
        }
        let recordingArrayDic = response["recordings"] as? [[String: Any]]
        let seriesArrayDic = response["series"] as? [[String: Any]]
        let timeUsed = response["time_used"] as? [String: Int] ?? [:]
        let recordingDecode = recordingArrayDic?.compactMap { Recording.decodable(jsonDictionary: $0) }
        let serieDecode = SeriesRecording.decodable(jsonDictionary: seriesArrayDic ?? [])
        let recordingListResponse = RecordingListResponse(recordings: recordingDecode ?? [],
                                                          series: serieDecode,
                                                          timeUsed: timeUsed)
        completion(.success(recordingListResponse))
        
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  //Get recording list with uri
  public func getRecordingListWithUri(_ uri:String, completion: @escaping (Result<[[String: Any]],NetworkError>) -> Void) {
    let getRecordingListWithUriRequest = RecordingRequest.getRecordingListWithUriRequest(uri: uri)
    NetworkDispatcher(environment: environment).fetchUriGet(uri: uri, from: getRecordingListWithUriRequest, baseParams: baseParameters, completion: { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData, let status = jsonData["status"] as? Int, status == 200, let response = jsonData["response"] as? [String: Any] else {
          completion(.failure(NetworkError.errorForWrongStructure()))
          return
        }
        let recording = response["recordings"] as? [[String: Any]]
        completion(.success(recording ?? []))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  // Get recording data
  public func getRecordingData(eventId: String,channelId: String, completion: @escaping (Result<Recording,NetworkError>) -> Void) {
    let getRecordingDataRequest = RecordingRequest.getRecordingDataWithEvent(eventId: eventId, channelId: channelId)
    NetworkDispatcher(environment: environment).fetch(request: getRecordingDataRequest, baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          guard let jsonData = response.jsonData, let status = jsonData["status"] as? Int, status == 200, let responseObj = jsonData["response"] as? [String: Any] else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
          }
          if !responseObj.isEmpty,
             let recording = Recording.decodable(jsonDictionary: responseObj) {            
            completion(.success(recording))
            return
          }
          completion(.failure(NetworkError.errorForWrongStructure()))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  // Delete recording
  public func deleteRecordingWithUri(_ uri:String, completion: @escaping (Result<[String: Any],NetworkError>) -> Void) {
    let deleteRecordingWithUriRequest = RecordingRequest.deleteRecordingDataWithUri(uri: uri)
    NetworkDispatcher(environment: environment).fetch(uri: uri, request: deleteRecordingWithUriRequest, baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          guard let jsonData = response.jsonData, let status = jsonData["status"] as? Int, status == 200, let response = jsonData["response"] as? [String: Any] else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
          }
          if response.count > 0 {
            completion(.success(response))
            return
          }
          completion(.failure(NetworkError.errorForWrongStructure()))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  //Play recording
  public func playRecordingDataWithUri(_ uri:String, paywayToken: String, completion: @escaping (Result<[String: Any],NetworkError>) -> Void) {
    let playRecordingDataWithUri = RecordingRequest.playRecordingDataWithUri(uri: uri, paywayToken: paywayToken)
    NetworkDispatcher(environment: environment).fetch(uri: uri, request: playRecordingDataWithUri, baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          guard let jsonData = response.jsonData, let status = jsonData["status"] as? Int, status == 200, let responseObject = jsonData["response"] as? [String: Any] else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
          }
          completion(.success(responseObject))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  public func addRecordingSerie(eventId:String, channelId: String, groupId: String, paywayToken: String, completion: @escaping (Result<Bool,NetworkError>) -> Void) {
    let addRecordingSerie = RecordingRequest.addRecordingSerie(eventId: eventId, channelId: channelId, groupId: groupId, paywayToken: paywayToken)
    NetworkDispatcher(environment: environment).fetch(request: addRecordingSerie, baseParams: baseParameters) { (result) in
      switch result {
      case .success:
        completion(.success(true))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

