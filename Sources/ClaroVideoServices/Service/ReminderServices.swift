//
//  ReminderServices.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public final class ReminderServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Reminder Service methods
  public func delete(reminderId: Int, completion: @escaping(Result<String?, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: ReminderRequest.delete(reminderId: reminderId), baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          if let json = response.jsonData,
            let lastTouchDic = json["lasttouch"] as? [String: Any] {
            let lastTouchResult = ParserHelper.parseObject(of: LastTouch.self, data: lastTouchDic)
            switch lastTouchResult {
              case .success(let lastTouch):
                completion(.success(lastTouch.reminder))
              default:
                completion(.failure(.errorForParseFailed(error: "Error in parse")))
            }
          }
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  public func create(channelId: Int, eventId: Int, type: String, expDate: Int, completion: @escaping(Result<String?, NetworkError>) -> Void) {
    let request = ReminderRequest.create(channelId: channelId, eventId: eventId, type: type, expDate: expDate)
    NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          if let json = response.jsonData,
            let lastTouchDic = json["lasttouch"] as? [String: Any] {
            let lastTouchResult = ParserHelper.parseObject(of: LastTouch.self, data: lastTouchDic)
            switch lastTouchResult {
              case .success(let lastTouch):
                completion(.success(lastTouch.reminder))
              default:
                completion(.failure(.errorForParseFailed(error: "Error in parse")))
            }
          }
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  public func list(completion: @escaping(Result<[ReminderListResponse],NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: ReminderRequest.list, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData, let reminders = jsonData["response"] as? [[String: Any]] else {
          completion(.failure(NetworkError.errorForWrongStructure()))
          return
        }
        completion(ParserHelper.parseObject(of: [ReminderListResponse].self, data: reminders, keyDecodingStrategy: .convertFromSnakeCase))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
