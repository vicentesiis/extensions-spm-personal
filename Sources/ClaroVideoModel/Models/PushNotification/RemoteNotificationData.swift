//
//  RemoteNotificationData.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 04/02/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class RemoteNotificationData: NSObject, JSONEncodable {
  let partner = "clv"
  public var partnerUserId: String?
  public var paymentMethod: String?
  public var userId: String?
  public var country: String = ""
  public var os: String = ""
  public var version: String = ""
  public var device: String = ""
  public var subscriptionType: String?
  public var userType: String = ""
  public var xappid: String?
  public var token: String = ""
}
