//
//  UserServices.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class UserServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Login and register Service methods
  public func getIsLoggedIn(completion: @escaping (Result<User,NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.isLoggedIn, baseParams: baseParameters) { result in
      switch(result) {
      case .success(let response):
        self.parseUser(response: response, completion: completion)
      case .failure(let error):
        switch error.code {
        case ErrorCodes.kErrorAPILoginAceptTerms.rawValue:
          completion(.failure(error))
        case ErrorCodes.kErrorAPILoginUserNotLogged.rawValue:
          let user = User()
          user.isUserLoggedIn = 0
          user.superhighlight = ["anonymous"]
          completion(.success(user))
        default:
          let user = User()
          user.isUserLoggedIn = 0
          user.superhighlight = ["anonymous"]
          completion(.success(user))
        }
      }
    }
  }
  
  public func loginSSORequestOTP(number: String, otp: String? = nil, completion: @escaping (Result<User?, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.loginsso(number: number, otp: otp), baseParams: baseParameters) { result in
      switch(result) {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String : AnyObject] {
          if (response["sent"] as? Bool) != nil {
            completion(.success(nil))
          } else {
            let parserResult = User.parseObject(dictionary: response)
            switch parserResult {
            case .success(let user):
              completion(.success(user))
            case .failure(let error):
              completion(.failure(error))
            }
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func loginEmail(user: String, pass: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
    loginOrRegister(request: UserRequest.login(user: user, password: pass), completion: completion)
  }
  
  public func loginHash(hash: String, userId: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
    loginOrRegister(request: UserRequest.loginHash(hash: hash, userId: userId), completion: completion)
  }
  
  public func loginSocial(userSocialId: String, socialnetwork: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
    loginOrRegister(request: UserRequest.loginSocial(userSocialId: userSocialId, socialnetwork: socialnetwork), completion: completion)
  }
  
  public func register(firstName: String, lastName: String, accepterms: Bool, email: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
    let registerRequest = UserRequest.register(firstName: firstName, lastName: lastName, accepterms: accepterms, email: email, password: password)
    loginOrRegister(request: registerRequest, completion: completion)
  }
  
  fileprivate func loginOrRegister(request: UserRequest, completion: @escaping (Result<User, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        self.parseUser(response: response, completion: completion)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  fileprivate func parseUser(response: Response, completion: @escaping (Result<User, NetworkError>) -> Void) {
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
  }
  
  public func logout(userId: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
    let logoutRequest = UserRequest.logout(userId: userId)
    NetworkDispatcher(environment: environment).fetch(request: logoutRequest, baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData, let response = json["response"] as? Bool {
          completion(.success(response))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getPushSession(userId: String, userSession: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.pushSession(userId: userId, userSession: userSession), baseParams: baseParameters) { result in
      switch(result) {
      case .success(let response):
        if let json = response.jsonData, let status = json["status"] as? Int {
          switch status {
          case 200:
            completion(.success(true))
          default:
            completion(.failure(NetworkError.errorForRecuestfailed()))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getUserInfo(email: String, completion: @escaping(Result<User, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.getUserInfo(email: email), baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          self.parseUser(response: response, completion: completion)
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  //MARK: - Modify user info
  public func modifyUserInfo(firstName: String, lastName: String, email :String, userHash:String, completion: @escaping (Result<String, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.modify(firstName: firstName, lastName: lastName, email: email, userHash: userHash), baseParams: baseParameters) { result in
      switch(result) {
      case .success(let response):
        if let json = response.jsonData, let response = json["response"] as? NSDictionary {
          
          if let responseCode = response["code"] as? String, responseCode == "update_successful" {
            completion(.success(responseCode))
          }
          else{
            completion(.failure(.errorForRecuestfailed()))
          }
          
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  //MARK: - Send Temporal Code
  public func sendTemporalCode(email: String, completion: @escaping(Result<Bool, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.sendTemporalCode(email: email), baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          if let json = response.jsonData,
             let response = json["response"] as? [String: Any],
             let sendCode = response["email_sent"] as? Bool {
            completion(.success(sendCode))
          } else {
            completion(.failure(.errorForParseFailed(error: "Error in parse")))
          }
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  //MARK: - Carousel Services
  public func getSeenRecommendations(path: String, completion: @escaping (Result<[(Group?, [Group])], NetworkError>) -> Void) {
      let request = UserRequest.seenRecommendations(path: path)
      NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { result in
      switch result {
        case .success(let response):
            var seenRecomendations: [(Group?, [Group])] = []
            
            if let json = response.jsonData,
                let response = json["response"] as? [String: Any],
                    let items = response["items"] as? NSArray {
                items.forEach { item in
                    if let dic = item as? [String: Any] {
                        var group: Group?
                        var listGroup: [Group] = []
                        
                        if let seen = dic["seen"] as? [String: Any] {
                            group = ParserHelper.parseSimpleObject(of: Group.self, data: seen)
                        }
                        if let recommendations = dic["recommendation"] as? NSArray {
                            listGroup = ParserHelper.parseSimpleObject(of: [Group].self, data: recommendations) ?? []
                        }
                        
                        seenRecomendations.append((group, listGroup))
                    }
                }
            }
            completion(.success(seenRecomendations))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  
  
  public func getLiveChannels(path: String, completion: @escaping (Result<[EPGChannel], NetworkError>)->()) {
    let request = UserRequest.liveChannels(path: path)
    NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { result in
    
    switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any],
          let groups = response["channels"] {
          let parserResult = ParserHelper.parseObject(of: [EPGChannel].self, data: groups)
          switch parserResult {
          case .success(let channels):
            completion(.success(channels))
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
  
  public func getSeen(path: String, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    requestForList(request: UserRequest.seen(path: path), completion: completion)
  }
  
  public func getSeen(gamificationId: String, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    requestForList(request: UserRequest.seenGamification(gamificationId: gamificationId), completion: completion)
  }
  
  public func getPurchasedActive(path: String, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    requestForList(request: UserRequest.purchased(path: path), completion: completion)
  }
  
  public func getUserRecomendations(completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    requestForList(request: UserRequest.userRecomendations, completion: completion)
  }
  
  public func deleteSeen(groupId: String, completion: @escaping(Result<String?, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.deleteSeen(groupId: groupId), baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          if let json = response.jsonData,
            let lastTouchDic = json["lasttouch"] as? [String: Any] {
            let lastTouchResult = ParserHelper.parseObject(of: LastTouch.self, data: lastTouchDic)
            switch lastTouchResult {
              case .success(let lastTouch):
                completion(.success(lastTouch.seen))
              default:
                completion(.failure(.errorForParseFailed(error: "Error in parse")))
            }
          }
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  public func deleteLinealChannel(groupId: String, completion: @escaping(Result<String?, NetworkError>)-> ()) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.deleteLinealChannels(groupId: groupId), baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          if let json = response.jsonData,
            let lastTouchDic = json["lasttouch"] as? [String: Any] {
            let lastTouchResult = ParserHelper.parseObject(of: LastTouch.self, data: lastTouchDic)
            switch lastTouchResult {
              case .success(let lastTouch):
                completion(.success(lastTouch.liveChannel))
              default:
                completion(.failure(.errorForParseFailed(error: "Error in parse")))
            }
          }
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  fileprivate func requestForList(request: UserRequest, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { (result) in
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
  
  //MARK: Bookmark
  public func getBookmark(groupList: String, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    requestForList(request: UserRequest.bookmark(groupId: groupList), completion: completion)
  }
  
  public func userSeenlast(groupId: String, completion: @escaping (Result<[String:Any], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: UserRequest.seenlast(groupId: groupId), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData {
          completion(.success(json))
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  //MARK: - Accept terms
  public func acceptTerms(password: String, username: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
    let requestUser = UserRequest.acceptTerms(password: password, username: username)
    acceptTerms(request: requestUser, completion: completion)
  }
  
  public func acceptTerms(userId: String, userHash: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
    let requestIp = UserRequest.acceptTermsIp(userHash: userHash, userId: userId)
    acceptTerms(request: requestIp, completion: completion)
  }
  
  fileprivate func acceptTerms(request: UserRequest, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { (result) in
      switch result {
      case .success:
        completion(.success(true))
      case .failure(let error):
        // Si los terminos ya se aceptaron mandamos directo al catalogo, si el error es diferente de already_accepted mostrar el alerta con el mensaje
        if let errorMessage = error.errorDescription,
          errorMessage == "already_accepted" {
          completion(.success(true))
        } else {
          completion(.failure(error))
        }
      }
    }
  }
}
