//
//  UserServicesTests.swift
//  ClaroVideoServicesTests
//
//  Created by Alejandro Perez on 10/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import XCTest
@testable import ClaroVideoServices

class UserServicesTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testFetchIsLoggedInFalse() {
    let expectation = XCTestExpectation(description: "User IsLoggedIn downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "ht8a50vrpf0k6s73o6m8t1rc95"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.getIsLoggedIn { (result) in
      switch result {
      case .success(let user):
        XCTAssertNotNil(user, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFetchIsLoggedInTrue() {
    let expectation = XCTestExpectation(description: "User IsLoggedIn downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "6u0kotepoper1i7e87v45mvtb5"
    params["region"] = "mexico"
    params["includpaywayprofile"] = true
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.getIsLoggedIn { (result) in
      switch result {
      case .success(let user):
        XCTAssertNotNil(user, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFetchPushSession() {
    let expectation = XCTestExpectation(description: "User PushSession downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "jtpb4bd91n3g9mc5pnukiukm76"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.getPushSession(userId: "32515180", userSession: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzQ5NTg0NjQsImV4cCI6MTU4MDE0Mjc2NCwidXNyIjp7IldHIjp7IlBBSVMiOiJNWCIsIkNPVU5UUllDT0RFX0lQIjoiTVgiLCJSRUdJT04iOiI0NDEiLCJOT01CUkVfUkVHSU9OIjoibWV4aWNvIiwiSURJT01BIjoiRVNQIiwiSUQiOiIyNyIsImlwUmVtb3RlQWRkcmVzcyI6IjIwMS4xMTYuNzguMiJ9LCJ1c3VhcmlvIjp7InN0b3JhZ2UiOnsiQUNUSVZPIjoiSCIsIklEX1VTVUFSSU8iOiIzMjUxNTE4MCIsIlVTRVJOQU1FIjoic3VzLmlwYWQubXguY3JhY2tsZUBnbWFpbC5jb20iLCJFTUFJTCI6InN1cy5pcGFkLm14LmNyYWNrbGVAZ21haWwuY29tIiwiTk9NQlJFIjoiTWFnbyIsIkFQRUxMSURPIjoiaW9zIiwiUElOX1BBUkVOVEFMIjpudWxsLCJDTEFTSUZJQ0FDSU9OX1BBUkVOVEFMIjpudWxsLCJURVJNSU5PU19BQ0VQVEFET1MiOiJTIiwiVElQT19VU1VBUklPIjoiQ01YQU1DTyIsIlFVSUVSRV9BRFVMVE8iOm51bGwsIklEX1NLSU4iOiIxIiwiSURfU1BDIjpudWxsLCJOT01CUkVfU0tJTiI6bnVsbCwiRVNUQURPIjpudWxsLCJFU1RBRE9fQUNUSVZPIjoiMSIsIkVYVF9JRF9VU1VfUEFSVE5FUiI6InN1cy5pcGFkLm14LmNyYWNrbGVAZ21haWwuY29tIiwiRVhUX0lEX1NFU19QQVJUTkVSIjpudWxsLCJFWFRfSURfVVNVX0FDQ09VTlQiOm51bGwsIkVYVF9JRF9VU1VfUFJPRFVDVCI6bnVsbCwiVVNFUl9QUk9EVUNUIjoiMjU0MCIsIlVTRVJfUFJPRFVDVF9UWVBFIjoiQSIsIk1FRElPX1BBR09fU1VTQ19HQVRFV0FZX05BTUUiOiJhbWNvZ2F0ZSIsIlBBSVNfVVNVQVJJTyI6Ik1YIiwiUkVHSU9OX1VTVUFSSU8iOiJtZXhpY28iLCJTVUJSRUdJT05fVVNVQVJJTyI6bnVsbCwiQ0lVREFEX1VTVUFSSU8iOm51bGwsIklEX01FRElPX1BBR09fTU9ORURBIjoiMjAzIiwiSURfTUVESU9fUEFHTyI6IjYyIiwiTk9NQlJFX01FRElPX1BBR08iOiJBbWNvIiwiTU9ORURBIjoiTVgiLCJNRURJT19QQUdPX0dBVEVXQVlfTkFNRSI6ImFtY29nYXRlIiwiRkVDSEFfTkFDSU1JRU5UTyI6bnVsbCwiRkVDSEFfQUxUQSI6IjI1LUpVTi0xOCIsIkxPR0lOX0ZFQ0hBIjpudWxsLCJSRURTT0NJQUxORVRXT1JLIjpudWxsLCJJRF9VU1VBUklPX1NPQ0lBTCI6bnVsbCwiRVhUUkFfREFUQSI6bnVsbCwiU09DSUFMX05FVFdPUktTIjpbeyJpZF91c3VhcmlvIjoiMzI1MTUxODAiLCJpZF91c3VhcmlvX3NvY2lhbCI6IjViMzE2YTU4MzkxYTk4NTc2NDUwNTc0MyIsInJlZHNvY2lhbCI6IklNVVNJQ0EiLCJleHRyYV9kYXRhIjpudWxsfV0sIlNFU0lPTl9GRUNIQSI6MTU3NDg5NDQyNiwiQ09VTlRFUl9WQUxJRF9FTUFJTCI6MSwiUEFSRU5UX0lEIjoiMzI1MTUxODAiLCJBRE1JTiI6dHJ1ZSwiRkFDRUJPT0tfSUQiOm51bGwsIkdBTUlGSUNBVElPTl9JRCI6IjViMzE2YTU4MzkxYTk4NTc2NDUwNTc0MyIsIkFDQ09VTlQiOm51bGx9fX19.niTBxMFGhlvAwRQp3WGarwQhTzEsaqxToCQmFV2-aws") { (result) in
      switch result {
      case .success(let success):
        XCTAssertNotNil(success, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testLoginEmailSuccess() {
    let expectation = XCTestExpectation(description: "Login User Email Success")
    var params = CommonParams().getBaseParams()
    params["HKS"]       = "6u0kotepoper1i7e87v45mvtb5"
    params["region"]    = "mexico"
    params["device_id"] = "B51499CE-452C-45FE-BCEF-2EB1526038C3"
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    
    userServices.loginEmail(user: "javier.bc121086@gmail.com", pass: "Milpajar_1") { (result) in
      switch result {
      case .success(let user):
        XCTAssertNotNil(user, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    
    wait(for: [expectation], timeout: 5.0)
  }
  
  
  func testRegisterUser() {
    let expectation = XCTestExpectation(description: "User Registered downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(t7debl83k73quvv6fnbg914nj6)"
    params["region"] = "mexico"
    params["device_so"] = "iOS"
    params["device_id"] = "B51499CE-452C-45FE-BCEF-2EB1526038C3"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.register(firstName: "JC", lastName: "Jobs", accepterms: true, email: "kimposible.perez@ironbit.com.mx", password: "P@swTest01") { (result) in
      switch result {
      case .success(let user):
        XCTAssertNotNil(user, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testLoginSSOUserWithOutOTP() {
    let expectation = XCTestExpectation(description: "Message sent")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(t7debl83k73quvv6fnbg914nj6)"
    params["region"] = "mexico"
    params["device_id"] = "0123456789"
    
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.loginSSORequestOTP(number: "7751288850") { (result) in
      switch result {
      case .success(let user):
        XCTAssertNil(user, "Message was sent")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 60.0)
  }
  
  
  func testLoginSSOUserWithOTP() {
    let expectation = XCTestExpectation(description: "Validate otp")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(t7debl83k73quvv6fnbg914nj6)"
    params["region"] = "mexico"
    params["device_id"] = "0123456789"
    
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.loginSSORequestOTP(number: "7751288850", otp: "28550946") { (result) in
      switch result {
      case .success(let user):
        print(user?.sessionUserHash ?? "No sessionUserHash data...")
        XCTAssertNotNil(user, "OTP couldn't be validated")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 60.0)
  }
  
  func testModifyUserInfo(){
    let expectation = XCTestExpectation(description: "Modify user info")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(t7debl83k73quvv6fnbg914nj6)"
    params["region"] = "mexico"
    params["device_id"] = "0123456789"
    
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.modifyUserInfo(firstName: "JC", lastName: "Jobs Torvalds", email: "juan.perez@ironbit.com.mx", userHash:"NDAyMTU0NDR8MTU3MTM4NzQyNXwxZTI5MjAyMjZhMzM5NTUzNmJhMGVmZGI3ZGQ5YWQzNDUwOTA3YjFjNGNmMTg0MjY1MA==") { (result) in
      switch result {
      case .success(let sucessMessahe):
        XCTAssertNotNil(sucessMessahe, "User info couldn't be modified")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 60.0)
  }
  
  func testSendPasswordReminderSuccessfuly() {
    /* Setup */
    var params = CommonParams().getBaseParams()
    params["HKS"] = "(t7debl83k73quvv6fnbg914nj6)"
    params["region"] = "mexico"
    params["device_so"] = "tvos"
    params["device_id"] = "0123456789"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    
    /* Test */
    let expectation = XCTestExpectation(description: "Send Password Reminder Successfuly")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.sendPasswordReminder(email: "name@mail.com") { result in
      switch result {
      case .success(let wasSent):
        /* Verify */
        XCTAssertTrue(wasSent, "Password Recovery was not sent")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testSendPasswordReminderEmailNotFound() {
    /* Setup */
    var params = CommonParams().getBaseParams()
    params["HKS"] = "(t7debl83k73quvv6fnbg914nj6)"
    params["region"] = "mexico"
    params["device_so"] = "tvos"
    params["device_id"] = "0123456789"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    
    /* Tets */
    let expectation = XCTestExpectation(description: "Send Password Reminder Email Not Found")
    let userServices = UserServices(environment: environment, baseParameters: params)
    userServices.sendPasswordReminder(email: "name@mail.com.mx") { result in
      switch result {
      case .success(let wasSent):
        print(wasSent)
      case .failure(let networkError):
        /* Verify */
        XCTAssertEqual(networkError.code, "USR_PSW_00002", "Another error happened")
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testLoginWithHash() {
    let expectation = XCTestExpectation(description: "Login User Hash Success")
    var params = CommonParams().getBaseParams()
    params["HKS"]       = "jtpb4bd91n3g9mc5pnukiukm76"
    params["region"]    = "mexico"
    params["device_id"] = "A9AC2A43-851F-4996-9FE5-B926BE7ED2C6"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let userServices = UserServices(environment: environment, baseParameters: params)
    
    userServices.loginHash(hash: "MzI1MTUxODB8MTU3MjExNDA1NnwxOWM2NDYwMjc3YzFhYWYzOTlkNThjYTA5Y2Q1MDViYmZmZDc2MzBmNTA3Y2RiOWZjYg==", userId: "32515180") { (result) in
      switch result {
      case .success(let user ):
        XCTAssertNotNil(user, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 8.0)
  }
  
  func testUserSeen() {
    let expectation = XCTestExpectation(description: "User Seen")
    var params = CommonParams().getBaseParams()
    params["HKS"]       = "on857mg8v6c0mhpbl93jgcen92"
    params["region"]    = "mexico"
    params["filterlist"] = "34429,34263,34450,34451,34469,35707,36018,32118"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "")
    let userServices = UserServices(environment: environment, baseParameters: params)
    
    userServices.seenWithUri(
    "/services/user/seen?lasttouch=5dceb68ee5580&user_hash=MzI1MTUxODB8MTU3MzgzNDk4OXwwZDlmM2IxZTA0ODIzYjliN2UxYjdlYTBiOTg4ODVjZThhYmU1M2FjMDQ1MDU2OTM1Yw%3D%3D&user_id=32515180&region=mexico") { (result) in
      switch result {
      case .success(let groups):
        XCTAssertNotNil(groups, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 8.0)
  }
  
  func testPurchasedActive() {
    let expectation = XCTestExpectation(description: "User Seen")
    var params = CommonParams().getBaseParams()
    params["HKS"]       = "ukap72ck13s91tbj876eifh0u7"
    params["region"]    = "mexico"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "")
    let userServices = UserServices(environment: environment, baseParameters: params)
    
    userServices.purchasedActiveWithUri(
    "/services/user/purchasedactive?lasttouch=5dc18caa444dc&user_hash=NDAzODQxMTR8MTU3MjkwOTIzN3xjMzljOGJlNjY4ZWFiY2IxMDNiMTZiNjlmNzQ0NmY1MzJkNTI2ZDRkOTNhYjc2Y2RjOQ%3D%3D&user_id=40384114&region=mexico") { (result) in
      switch result {
      case .success(let groups):
        XCTAssertNotNil(groups, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 8.0)
  }
  
  func testSeenRecommendations() {
    let expectation = XCTestExpectation(description: "Get seen recommendations ")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(cbde3ecba058ac8875b09994b3f0ed84)"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "")
    let service = UserServices(environment: environment, baseParameters: params)
    service.getSeenRecommendations(uri: "/services/user/seenrecommendations?visquant=5&recquant=1&offset=1&user_hash=MzI1MTUxODB8MTU3Mjk5NTgwMHxlZjg5MTAwY2E5NjQ2YTQ2N2U3Y2VkNWFjYjBmZWNkMmJkYTA3ZWM3NDMzZjNkZWQ2Mw%3D%3D&user_id=32515180&region=mexico",
                                   completion: { (result) in
                                    switch result {
                                    case .success(let data):
                                      XCTAssertNotNil(data, "No data was downloaded.")
                                      expectation.fulfill()
                                    case .failure(let networkError):
                                      print(networkError)
                                    }
    })
    wait(for: [expectation], timeout: 30.0)
  }
  
  
  func testSeenRecommendationsWithFilterList() {
    let expectation = XCTestExpectation(description: "Get seen recommendations with filter list")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(cbde3ecba058ac8875b09994b3f0ed84)"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "")
    let service = UserServices(environment: environment, baseParameters: params)
    service.getSeenRecommendations(uri: "/services/user/seenrecommendations?visquant=5&recquant=1&offset=1&user_hash=MzI1MTUxODB8MTU3Mjk5NTgwMHxlZjg5MTAwY2E5NjQ2YTQ2N2U3Y2VkNWFjYjBmZWNkMmJkYTA3ZWM3NDMzZjNkZWQ2Mw%3D%3D&user_id=32515180&region=mexico",
                                   completion: { (result) in
                                    switch result {
                                    case .success(let data):
                                      XCTAssertNotNil(data, "No data was downloaded.")
                                      expectation.fulfill()
                                    case .failure(let networkError):
                                      print(networkError)
                                    }
    })
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testLogut() {
    let expectation = XCTestExpectation(description: "Log out user")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(jtpb4bd91n3g9mc5pnukiukm76)"
    params["region"] = "mexico"
    params["user_agent"] = "IosDlaApk"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let service = UserServices(environment: environment, baseParameters: params)
    service.logout(userId: "32515180") { result in
      switch result {
      case .success(let data):
        XCTAssertNotNil(data, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testGetBookmark() {
    let expectation = XCTestExpectation(description: "Get Bookmark data")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "jtpb4bd91n3g9mc5pnukiukm76"
    params["region"] = "mexico"
    params["lasttouch"] = "5ddc5bbb548c6"
    params["filter_list"] = "34429,34263,34450,34451,34469,35707,36018,32118"
    params["user_hash"] = "MzI1MTUxODB8MTU3NDcyMjYwN3w3OTg4NDFmZTE4ZjZjMmUwYjQ0ZTAzNzVjOTM1MmU5NzFhYzlhZWI3MmMxY2U0MDYwOA=="
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let service = UserServices(environment: environment, baseParameters: params)
    service.getBookmark(groupId: "599764,599981,599785,599941,599771,599781,599787,599775,599774,599801,599770,599786,599763,599767,599780,599766,599768,599773,599803,599762") { result in
      switch result {
      case .success(let groups):
        XCTAssertNotNil(groups, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testFavoriteAdd() {
    let expectation = XCTestExpectation(description: "Add Favorite")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(jtpb4bd91n3g9mc5pnukiukm76)"
    params["region"] = "mexico"
    params["object_type"] = "1"
    params["user_id"] = "32515180"
    params["user_hash"] = "MzI1MTUxODB8MTU3NDc4MTEyMHwxNjRiNDA2MjM4MTg1OTM0OGYwYWM0YmEwMTNkNDI0MmY4NzAyYTA0YzU0YWY1ZmIxZQ=="
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let service = UserServices(environment: environment, baseParameters: params)
    service.favoriteAdd(groupId: "784213") { result in
      switch result {
      case .success(let data):
        XCTAssertNotNil(data, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFavoriteDelete() {
    let expectation = XCTestExpectation(description: "Delete Favorite")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(jtpb4bd91n3g9mc5pnukiukm76)"
    params["region"] = "mexico"
    params["object_type"] = "1"
    params["user_id"] = "32515180"
    params["user_hash"] = "MzI1MTUxODB8MTU3NDc4MTEyMHwxNjRiNDA2MjM4MTg1OTM0OGYwYWM0YmEwMTNkNDI0MmY4NzAyYTA0YzU0YWY1ZmIxZQ=="
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/user/")
    let service = UserServices(environment: environment, baseParameters: params)
    service.favoriteDelete(groupId: "784213") { result in
      switch result {
      case .success(let data):
        XCTAssertNotNil(data, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
}
