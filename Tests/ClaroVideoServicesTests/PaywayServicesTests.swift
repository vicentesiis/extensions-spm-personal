//
//  PaywayServicesTests.swift
//  ClaroVideoServicesTests
//
//  Created by Alejandro Perez on 11/21/19.
//  Copyright © 2019 amco. All rights reserved.
//

import XCTest
@testable import ClaroVideoServices

class PaywayServicesTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testGetPurchaseButtonInfo() {
    let expectation = XCTestExpectation(description: "Get Purchase Button Info")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "2pd17dpi13qh50qks3mgge0ov3"
    params["region"] = "mexico"
    params["device_so"] = "iOS"
    params["device_id"] = "B51499CE-452C-45FE-BCEF-2EB1526038C3"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/payway/")
    let service = PaywayServices(environment: environment, baseParameters: params)
    service.getPurchaseButtonInfo(userId: "41161439", groupId: "795314") { result in // Black Swan 562362 Picardia? 794450
      switch result {
      case .success(let purchaseButtonInfo):
        XCTAssertNotNil(purchaseButtonInfo, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testFetchWorkFlowStartiTunesWithURL() {
    let expectation = XCTestExpectation(description: "Fetch Workflow")
    var params: [String: Any] = [:]
    params["HKS"] = "8odq321mmo6eoc6mq75c6abu80"
    params["device_type"] = "Apple TV"
    params["device_category"] = "tablet"
    params["region"] = "mexico"
    params["device_name"] = "Game Room"
    params["device_manufacturer"] = "aapl"
    params["device_model"] = "aapl"
    params["authpn"] = "amco"
    params["user_id"] = "41161439"
    params["format"] = "json"
    params["authpt"] = "12e4i8l6a581a"
    params["api_version"] = "v5.88"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "")
    let service = PaywayServices(environment: environment, baseParameters: params)
    service.fetchWorkFlowStartiTunesWithURL("/services/payway/workflowstart?object_type=A&offer_id=14327565&suscription_id=2940&device_category=tablet&device_manufacturer=aapl&device_model=aapl&device_type=Apple+TV&HKS=%288odq321mmo6eoc6mq75c6abu80%29&region=mexico&rate_id=143275653615&user_id=41161439") { result in
      switch result {
      case .success((let workflow, let gateway)):
        XCTAssertNotNil(workflow, "No data was downloaded.")
        print(workflow)
        print(gateway)
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
   wait(for: [expectation], timeout: 10.0)
  }
  
  func testGetLinealChannels() {
    let expectation = XCTestExpectation(description: "Fetch Workflow")
    var params: [String: Any] = [:]
    params["HKS"] = "7qjps75bsgs02e9ngonta7ngd2"
    params["device_type"] = "Apple TV"
    params["device_category"] = "tablet"
    params["region"] = "mexico"
    params["device_name"] = "Game Room"
    params["device_manufacturer"] = "aapl"
    params["device_model"] = "aapl"
    params["authpn"] = "amco"
    params["user_id"] = "41161439"
    params["format"] = "json"
    params["authpt"] = "12e4i8l6a581a"
    params["api_version"] = "v5.88"
    //NOTE:- La prueba se realiza con el de tablet ya que caemos en respuesta exitosa y podemos probar si se mapea de manera correcta la respuesta
    let environment = Environment(httpProtocol: .https, host: "mfwktabletios-api.clarovideo.net", port: "/services/payway/")
    let service = PaywayServices(environment: environment, baseParameters: params)
    service.getLinealChannel(withUserHash: "", userID: "") { result in
      switch result {
      case .success(let channelPackages):
        XCTAssertNotNil(channelPackages, "No data was downloaded.")
        print(channelPackages)
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    
   wait(for: [expectation], timeout: 10.0)
  }

  func test_parseResponse_withSuccessResponse_multipurchaseButtonInfo() throws {
    let json = PaywayServicesTestHelper.getMultiPurchaseButtonInfoJSONObject()
    if let response = json["data"] as? [String: Any] {
      let parserResult = PurchaseButtonInfo.parseMultiPurchaseButtonObject(dictionary: response as [String : AnyObject])
      XCTAssertNotNil(parserResult, "Error parsing JSON object")
      switch parserResult {
      case .success(let purchaseButtonInfo):
        XCTAssertNotNil(purchaseButtonInfo.listButtons, "Parser error")
      case .failure(_): break
      }
    } else {
      XCTAssertNotNil(json, "JSON data is nil")
    }
  }
}
