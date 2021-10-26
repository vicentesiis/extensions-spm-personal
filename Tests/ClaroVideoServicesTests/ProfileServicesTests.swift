//
//  ProfileServicesTests.swift
//  ClaroVideoServicesTests
//
//  Created by Alejandro Perez on 10/21/19.
//  Copyright © 2019 amco. All rights reserved.
//

import XCTest
@testable import ClaroVideoServices

class ProfileServicesTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testGetProfiles() {
    let expectation = XCTestExpectation(description: "Get Profiles downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(jtpb4bd91n3g9mc5pnukiukm76)"
    params["region"] = "mexico"
    params["user_id"] = "32515180"
    params["device_id"] = "B51499CE-452C-45FE-BCEF-2EB1526038C3"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let profileServices = ProfileServices(environment: environment, baseParameters: params)
    profileServices.getProfiles(userToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzE2ODQ4NjksImV4cCI6MTU3Njg2OTE2OSwidXNyIjp7InVzZXJfaWQiOiIzMjUxNTE4MCIsInVzZXJfdHlwZSI6IkNNWEFNQ08iLCJ1c2VybmFtZSI6InN1cy5pcGFkLm14LmNyYWNrbGVAZ21haWwuY29tIiwiZW1haWwiOiJzdXMuaXBhZC5teC5jcmFja2xlQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6ImNyYWNrbGUgc3VzY3JpcGNpb24iLCJsYXN0bmFtZSI6ImlvcyIsImNvdW50cnlfY29kZSI6Ik1YIiwicmVnaW9uIjoibWV4aWNvIiwiYWNjZXB0ZWRfdGVybXMiOjEsImdhbWlmaWNhdGlvbl9pZCI6IjViMzE2YTU4MzkxYTk4NTc2NDUwNTc0MyIsInBhcmVudF9pZCI6IjMyNTE1MTgwIiwiYWNjb3VudCI6bnVsbCwiYWRtaW4iOnRydWV9fQ.grLjcj-OZ3bGTpQjoG1AXG6nH8v7rnkwBhsEje-iZlk",
                                gamificationId: "5b316a58391a985764505743") { (result) in
                                  switch result {
                                  case .success(let profiles):
                                    XCTAssertNotNil(profiles, "No data was downloaded.")
                                    expectation.fulfill()
                                  case .failure(let networkError):
                                    print(networkError)
                                  }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testGetAvatars() {
    let expectation = XCTestExpectation(description: "Get Avatars images downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(jtpb4bd91n3g9mc5pnukiukm76)"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let profileServices = ProfileServices(environment: environment, baseParameters: params)
    profileServices.getAvatars { (result) in
      switch result {
      case .success(let avatars):
        XCTAssertNotNil(avatars, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
        
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testCreateProfile() {
    let expectation = XCTestExpectation(description: "Create Profile downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(jtpb4bd91n3g9mc5pnukiukm76)"
    params["region"] = "mexico"
    params["device_id"] = "B51499CE-452C-45FE-BCEF-2EB1526038C3"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let profileServices = ProfileServices(environment: environment, baseParameters: params)
    profileServices.createProfile(name: "Kings Leon",
                                  imageUri: "http://clarovideocdn1.clarovideo.net/pregeneracion/cms/apa/d2dc71d6fb6d51272b3b162a/avatar09.png?1560443227",
                                  userToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzE2ODk1OTIsImV4cCI6MTU3Njg3Mzg5MiwidXNyIjp7InVzZXJfaWQiOiIzMjUxNTE4MCIsInVzZXJfdHlwZSI6IkNNWEFNQ08iLCJ1c2VybmFtZSI6InN1cy5pcGFkLm14LmNyYWNrbGVAZ21haWwuY29tIiwiZW1haWwiOiJzdXMuaXBhZC5teC5jcmFja2xlQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6ImNyYWNrbGUgc3VzY3JpcGNpb24iLCJsYXN0bmFtZSI6ImlvcyIsImNvdW50cnlfY29kZSI6Ik1YIiwicmVnaW9uIjoibWV4aWNvIiwiYWNjZXB0ZWRfdGVybXMiOjEsImdhbWlmaWNhdGlvbl9pZCI6IjViMzE2YTU4MzkxYTk4NTc2NDUwNTc0MyIsInBhcmVudF9pZCI6IjMyNTE1MTgwIiwiYWNjb3VudCI6bnVsbCwiYWRtaW4iOnRydWV9fQ.3OcirCPGPZf6srXLBnQH19l8aGelHj1FEyH9RQY0GHM") { (result) in
                                    switch result {
                                    case .success(let profileGroup):
                                      XCTAssertNotNil(profileGroup, "No data was downloaded.")
                                      expectation.fulfill()
                                    case .failure(let networkError):
                                      print(networkError)
                                    }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  func testUpdateProfile() {
    let expectation = XCTestExpectation(description: "Update Profile downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(jtpb4bd91n3g9mc5pnukiukm76)"
    params["region"] = "mexico"
    params["device_id"] = "B51499CE-452C-45FE-BCEF-2EB1526038C3"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let profileServices = ProfileServices(environment: environment, baseParameters: params)
    profileServices.updateProfile(name: "Paul",
                                  imageUri: "http://clarovideocdn1.clarovideo.net/pregeneracion/cms/apa/d2dc71d6fb6d51272b3b162a/avatar16.png?1560443367",
                                  userToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzE2ODk1OTIsImV4cCI6MTU3Njg3Mzg5MiwidXNyIjp7InVzZXJfaWQiOiIzMjUxNTE4MCIsInVzZXJfdHlwZSI6IkNNWEFNQ08iLCJ1c2VybmFtZSI6InN1cy5pcGFkLm14LmNyYWNrbGVAZ21haWwuY29tIiwiZW1haWwiOiJzdXMuaXBhZC5teC5jcmFja2xlQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6ImNyYWNrbGUgc3VzY3JpcGNpb24iLCJsYXN0bmFtZSI6ImlvcyIsImNvdW50cnlfY29kZSI6Ik1YIiwicmVnaW9uIjoibWV4aWNvIiwiYWNjZXB0ZWRfdGVybXMiOjEsImdhbWlmaWNhdGlvbl9pZCI6IjViMzE2YTU4MzkxYTk4NTc2NDUwNTc0MyIsInBhcmVudF9pZCI6IjMyNTE1MTgwIiwiYWNjb3VudCI6bnVsbCwiYWRtaW4iOnRydWV9fQ.3OcirCPGPZf6srXLBnQH19l8aGelHj1FEyH9RQY0GHM",
                                  gamificationId: "5dae18048556622a39215fb0") { (result) in
                                    switch result {
                                    case .success(let profileMember):
                                      XCTAssertNotNil(profileMember, "No data was downloaded.")
                                      expectation.fulfill()
                                    case .failure(let networkError):
                                      print(networkError)
                                    }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testDeleteProfile() {
    let expectation = XCTestExpectation(description: "Update Profile downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(jtpb4bd91n3g9mc5pnukiukm76)"
    params["region"] = "mexico"
    params["device_id"] = "B51499CE-452C-45FE-BCEF-2EB1526038C3"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let profileServices = ProfileServices(environment: environment, baseParameters: params)
    profileServices.deleteProfile(userToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzE2ODk1OTIsImV4cCI6MTU3Njg3Mzg5MiwidXNyIjp7InVzZXJfaWQiOiIzMjUxNTE4MCIsInVzZXJfdHlwZSI6IkNNWEFNQ08iLCJ1c2VybmFtZSI6InN1cy5pcGFkLm14LmNyYWNrbGVAZ21haWwuY29tIiwiZW1haWwiOiJzdXMuaXBhZC5teC5jcmFja2xlQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6ImNyYWNrbGUgc3VzY3JpcGNpb24iLCJsYXN0bmFtZSI6ImlvcyIsImNvdW50cnlfY29kZSI6Ik1YIiwicmVnaW9uIjoibWV4aWNvIiwiYWNjZXB0ZWRfdGVybXMiOjEsImdhbWlmaWNhdGlvbl9pZCI6IjViMzE2YTU4MzkxYTk4NTc2NDUwNTc0MyIsInBhcmVudF9pZCI6IjMyNTE1MTgwIiwiYWNjb3VudCI6bnVsbCwiYWRtaW4iOnRydWV9fQ.3OcirCPGPZf6srXLBnQH19l8aGelHj1FEyH9RQY0GHM",
                                  gamificationId: "5dae1e717b5b21764c5b724c") { (result) in
                                    switch result {
                                    case .success(let profileGroup):
                                      XCTAssertNotNil(profileGroup, "No data was downloaded.")
                                      expectation.fulfill()
                                    case .failure(let networkError):
                                      print(networkError)
                                    }
    }
    wait(for: [expectation], timeout: 5.0)
  }
}
