//
//  Recording+Status.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 11/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public enum RecordingStatus: Int {

  case none = 0
  case error = -1
  case recording = 1
  case scheduled = 2
  case ingested = 3
  case scheduledAndRecording = 4

  static func getRecordingStatusFrom(string:String) -> RecordingStatus {
    var status: RecordingStatus = .none

    if string == "ERROR" {
      status = .error
    } else if string == "recording" {
      status = .recording
    }else if string == "scheduled" {
      status = .scheduled
    }else if string == "ingested" {
      status = .ingested
    }

    return status
  }
}

