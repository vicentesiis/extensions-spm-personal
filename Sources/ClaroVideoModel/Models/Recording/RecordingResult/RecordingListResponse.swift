//
//  RecordingListResponse.swift
//  ClaroVideoServices
//
//  Created by Oscar Montaño Ayala on 20/08/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public struct RecordingListResponse {
  public let recordings: [Recording]
  public let series: [SeriesRecording]
  public let timeUsed: [String: Int]
}
