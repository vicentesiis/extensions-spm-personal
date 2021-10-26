//
//  CommonParams.swift
//  ClaroVideoServices
//
//  Created by alonso.salcido on 11/16/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

public final class CommonParams {
    
    public init() {
        
    }
  
  fileprivate struct Constants {
    static let apiVersion = "v5.88"
    static let format = "json"
    static let authpn = "amco"
    static let authpt = "12e4i8l6a581a"
    static let hks = "sesionHKS"
    static let region = "sesionRegion"
  }
  
  var hks: String {
    return UserDefaults.standard.object(forKey: Constants.hks) as? String ?? ""
  }
  
  var region: String {
    return UserDefaults.standard.object(forKey: Constants.region) as? String ?? ""
  }
  
  public func getCommonParams() -> [String:Any] {
    return ["device_manufacturer": DeviceInfo.getManufacturer,
            "device_model": DeviceInfo.getModel,
            "device_category": DeviceInfo.getCategory,
            "device_type": DeviceInfo.getType,
            "device_name": DeviceInfo.getName,
            "api_version": Constants.apiVersion,
            "format": Constants.format,
            "authpn": Constants.authpn,
            "authpt": Constants.authpt]
  }
  
  public func getCommonExtendedParams() -> [String:Any] {
    return ["HKS": self.hks,
            "region": self.region]
  }
  
  public func getBaseParams() -> [String:Any]{
    let comonParams = getCommonParams()
    let commonExtendedParams = getCommonExtendedParams()
    return comonParams.merging(commonExtendedParams, uniquingKeysWith: { (current, _) -> Any in current})
  }
}

