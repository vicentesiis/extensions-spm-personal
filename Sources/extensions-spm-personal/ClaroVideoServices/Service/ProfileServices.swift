//
//  ProfileServices.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 23/08/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class ProfileServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?

  // MARK: -Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }

  public func createProfile(name:String, imageUri:String, userToken: String, isKid: Bool = false, completion:@escaping ((Result<CVProfileGroup,NetworkError>) -> Void)) {
    let createProfileRequest = ProfileRequest.createProfile(name: name, imageUri: imageUri, userToken: userToken, isKid: isKid)
    NetworkDispatcher(environment: environment).fetch(request: createProfileRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let jsonResponse = response.jsonData,
          let statusObject = jsonResponse["status"] as? String {
          if let responseDic = jsonResponse["response"] as? [String: Any],
            statusObject == "0" {
            //return profile group
            let responseCVProfile = CVProfileGroup.parseObject(dictionary: responseDic)
            switch responseCVProfile {
            case .success(let cvProfile):
              completion(.success(cvProfile))
              break
            case .failure(let error):
              completion(.failure(error))
              break
            }
          } else if let errors = jsonResponse["errors"] as? [String: Any],
            let code = errors["code"] as? String {
            //error with code
            completion(.failure(NetworkError.errorWithCode(code)))
          } else {
            //wrongStructure
            completion(.failure(NetworkError.errorForWrongStructure()))
          }
        } else {
          // error in response json
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
        break
      case .failure(let error):
        completion(.failure(error))
        break
      }
    }
  }

  public func updateProfile(member: CVProfileMember, userToken: String, completion:@escaping ((Result<CVProfileMember,NetworkError>) -> Void)) {
    let updateProfileRequest = ProfileRequest.updateProfile(name: member.userName, imageUri: member.userImage, userToken: userToken, gamificationId: member.gamificationId, isKid: member.isKid)
    NetworkDispatcher(environment: environment).fetch(request: updateProfileRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonDic = response.jsonData,
          let statusObject = jsonDic["status"] as? String else {
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        // Check status and decode object
        if let responseDic = jsonDic["response"] as? [String: Any],
          statusObject == "0",
          let profileMember = CVProfileMember.decode(jsonDic: responseDic) {
          //return profile member
          completion(.success(profileMember))
        } else if let errors = jsonDic["errors"] as? [String: Any],
          let code = errors["code"] as? String {
          //error with code
          completion(.failure(NetworkError.errorWithCode(code)))
        } else {
          //wrongStructure
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
        break
      case .failure(let error):
        completion(.failure(error))
        break
      }
    }
  }

  public func deleteProfile(userToken: String,gamificationId: String, completion:@escaping ((Result<CVProfileGroup,NetworkError>) -> Void)) {
    let deleteProfileRequest = ProfileRequest.deleteProfile(userToken: userToken, gamificationId: gamificationId)
    NetworkDispatcher(environment: environment).fetch(request: deleteProfileRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData,
          let statusObject = jsonData["status"] as? String else {
            //wrongStructure
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        // Check status and decode object
        if let responseDic = jsonData["response"] as? [String: Any],
          statusObject == "0" {
          let profileGroupParse = CVProfileGroup.parseObject(dictionary: responseDic)
          switch profileGroupParse {
          case .success(let profileGroup):
            completion(.success(profileGroup))
            break
          case .failure(let error):
            completion(.failure(error))
            break
          }
          //return profile group
        } else if let errors = jsonData["errors"] as? [String: Any],
          let code = errors["code"] as? String {
          //error with code
          completion(.failure(NetworkError.errorWithCode(code)))
        } else {
          //wrongStructure
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
        break
      case .failure(let error):
        completion(.failure(error))
        break
      }
    }
  }

  public func getProfiles(userToken: String, gamificationId: String, completion:@escaping ((Result<CVProfileGroup,NetworkError>) -> Void)) {
    let getProfilesRequest = ProfileRequest.getProfiles(userToken: userToken, gamificationId: gamificationId)
    NetworkDispatcher(environment: environment).fetch(request: getProfilesRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let result):
        guard let jsonData = result.jsonData,
          let statusObject = jsonData["status"] as? String else {
            //wrongStructure
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        // Check status and decode object
        if let responseDic = jsonData["response"] as? [String: Any],
          statusObject == "0" {
          //parse profile group
          let profileGroupParse = CVProfileGroup.parseObject(dictionary: responseDic)
          switch profileGroupParse {
          case .success(let profileGroup):
            completion(.success(profileGroup))
            break
          case .failure(let error):
            completion(.failure(error))
            break
          }
        } else if let errors = jsonData["errors"] as? [String: Any],
          let code = errors["code"] as? String {
          //error with code
          completion(.failure(NetworkError.errorWithCode(code)))
        } else {
          //wrongStructure
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
        break
      case .failure(let error):
        completion(.failure(error))
        break
      }
    }
  }

  public func getAvatars( completion:@escaping ((Result<[CVProfileAvatar],NetworkError>) -> Void)) {
    let getAvatarRequest = ProfileRequest.getAvatars
    NetworkDispatcher(environment: environment).fetch(request: getAvatarRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        guard let jsonData = response.jsonData,
          let responseDic = jsonData["response"] as? [String: Any]  else {
            //wrongStructure
            completion(.failure(NetworkError.errorForWrongStructure()))
            return
        }
        // Check status and decode object
        var avatars:[CVProfileAvatar] = []
        if let avatarArrayDic = responseDic["avatars"] as? [[String: Any]] {
          for avatarDic in avatarArrayDic {
            let avatarParse = CVProfileAvatar.parseObject(dictionary: avatarDic)
            switch avatarParse {
            case .success(let avatar):
              avatars.append(avatar)
              break
            case .failure:
              break
            }
          }
        }
        if avatars.count > 0 {
          //return profile group
          completion(.success(avatars))
        } else if let errors = responseDic["errors"] as? [String: Any],
          let code = errors["code"] as? String {
          //error with code
          completion(.failure(NetworkError.errorWithCode(code)))
        } else {
          //wrongStructure
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
        break
      case .failure(let error):
        completion(.failure(error))
        break
      }
    }    
  }
}
