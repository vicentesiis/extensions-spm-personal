//
//  ReminderListResponse.swift
//  ClaroVideoServices
//
//  Created by Juan Carlos  Carrera on 04/05/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public struct ReminderListResponse: Decodable {
  public let id: String
  public let channelId: String
  public let eventId: String
  public let expDate: Int
  public let userId: String
  public let type: String
  public let data: ReminderListData
}

public final class ReminderListData: Decodable {
  public let unixBegin: Int
  public let id: String
  public let name: String
  public let channelId: String
  @RelaxedValue public var channelNumber: Int
  public let channelName: String
  public let channelGroupId: String
  public let channelLiveref: String
  public let channelImage: String
}
