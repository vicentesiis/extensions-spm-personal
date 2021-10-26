//
//  ClaroDashboard.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 16/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public protocol ClaroDashboardDelegate: AnyObject {
  func getClaroDashboardUri() -> String?
  func getDashboardDefaultParams() -> [String:Any]
}

public final class ClaroDashboard: NSObject {
  //MARK: Properties
  fileprivate var didErrorHappen: Bool = false
  fileprivate var didManuallySeekHappen: Bool = false
  fileprivate var didEndContent: Bool = false
  fileprivate var didManuallyPauseHappen: Bool = false
  fileprivate var isQualityChange: Bool = false
  fileprivate var hlsPlayerCurrentTime: TimeInterval = 0
  fileprivate let playerTimeSkip: Double = 30
  public weak var delegate: ClaroDashboardDelegate?
  public var dashboardConfiguration: ClaroDashboardConfiguration?
  public static var shared: ClaroDashboard = ClaroDashboard()
  
  private override init() {
    super.init()
  }
  
  //MARK: Methods
  // Method to send information of player events and playergetmedia API status
  fileprivate func sendEvent(_ event: ClaroDashboardOperators, parameters: [String:Any], success: (([String:Any]?) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
    
    guard let claroDashboardUri = delegate?.getClaroDashboardUri(),
          !parameters.isEmpty else {return}
    
    if event == .pgm {
      didEndContent = false
    }
    
    //Create Enviroment and PlayerServices instance
    let environment = Environment(httpProtocol: .http, host: "", port: "")
    let playerServices = PlayerServices(environment: environment, baseParameters: parameters)
    
    playerServices.sendDashboardEvent(withURI: claroDashboardUri) { (result) in
      switch (result) {
        case .success(let response):
          success?(response)
        case .failure:
          success?([:])
      }
    }
  }
  
  // Method to send information of player events and playergetmedia API status
  public func sendEvent(_ event: ClaroDashboardOperators, playerMedia: PlayerMedia, success: (([String:Any]?) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
    // Get parameters
    let parameters = buildParameters(by: event, playerMedia: playerMedia, error: nil)
    // Send parameters and perform request
    sendEvent(event, parameters: parameters, success: success, failure: failure)
  }
  
  fileprivate func sendSeekEvent(_ event: ClaroDashboardOperators, playerMedia:PlayerMedia, startTime:TimeInterval, endTime:TimeInterval) {
    var eventToSend:ClaroDashboardOperators = event
    // Get parameters
    let parameters = buildParameters(by: eventToSend, playerMedia: playerMedia, startTime: startTime, endTime: endTime, bitrate: 0, error: nil)
    
    // If an error ocurred next "buferring_start" or "bufering_end" must be "rebuferring_start" or "rebufering_end"
    if didErrorHappen && event == .bufferingStart {
      eventToSend = .reBufferingStart
      didErrorHappen = false
    } else if didErrorHappen && event == .bufferingEnd {
      eventToSend = .reBufferingEnd
      didErrorHappen = false
    }
    // Send parameters and perform request
    sendEvent(eventToSend, parameters: parameters, success: nil, failure: nil)
  }
  
  public func sendBitrateEvent(bitrate:Int, playerMedia:PlayerMedia) {
    // Get parameters
    let params = buildParameters(by: .bitrate, playerMedia: playerMedia, startTime: 0, endTime: 0, bitrate: bitrate, error: nil)
    // Send parameters and perform request
    sendEvent(.bitrate, parameters: params, success: nil, failure: nil)
  }
  
  public func sendEvent(_ event: ClaroDashboardOperators, error:Error?) {
    // Get parameters
    let params = buildParameters(by: event, playerMedia: nil, error: error)
    // Send parameters and perform request
    sendEvent(event, parameters: params, success: nil, failure: nil)
  }
  
  public func sendSeekManuallyEvent(_ event: ClaroDashboardOperators, startTime:TimeInterval, endTime:TimeInterval) { //, playerMedia:PlayerMedia
    var time = endTime
    if endTime.isNaN {
      time = 0
    }
    didManuallySeekHappen = true
    
    let startTimeInSeconds = lroundf(Float(startTime))
    let endTimeInSeconds = lroundf(Float(time))
    var eventToSend = event
    
    if event == .forward30 || event == .rewind30 {
      eventToSend = event
    } else if startTime < time {
      /* ClaroDashboard forward */
      eventToSend = .forward
    } else {
      /* ClaroDashboard rewind */
      eventToSend = .rewind
    }
    guard let mediaPlayer = dashboardConfiguration?.playerMedia else { return }
    sendSeekEvent(eventToSend, playerMedia: mediaPlayer, startTime: TimeInterval(startTimeInSeconds), endTime: TimeInterval(endTimeInSeconds))
    
    /* ClaroDashboard seek */
    sendSeekEvent(.seek, playerMedia: mediaPlayer, startTime: TimeInterval(startTimeInSeconds), endTime: TimeInterval(endTimeInSeconds))
  }
  
  public func sendClosePlayer() {
    guard let mediaPlayer = dashboardConfiguration?.playerMedia else { return }
    if !didEndContent {
      /* ClaroDashboard stop */
      ClaroDashboard.shared.sendEvent(.stop, playerMedia: mediaPlayer)
    }
    /* ClaroDashboard leave */
    ClaroDashboard.shared.sendEvent(.leave, playerMedia: mediaPlayer)
  }
  
  //MARK: - Parameters
  // Method to set all parameters that needs to be send
  fileprivate func buildParameters(by event: ClaroDashboardOperators, playerMedia: PlayerMedia?, startTime: TimeInterval = 0, endTime: TimeInterval = 0, bitrate: Int = 0, error: Error?) -> [String:Any] {
    // Default parameters like device, user and app data
    var params = delegate?.getDashboardDefaultParams() ?? [:]
    // Akamai headers data
    if let dictHeaders = playerMedia?.httpHeaders as? [String:String] {
      let headers = parameters(for: dictHeaders)
      if headers.keys.count > 0 {
        params["cdn"] = headers
      }
    }
    
    // Operator data
    var operatorDic:[String:Any] = [:]
    operatorDic["contentid"] = playerMedia?.group?.group_id
    operatorDic["operatorKey"] = event.rawValue
    
    // Request and reponse data
    params["URL"] = playerMedia?.requestURL ?? ""
    
    // Request and Response only for pgm
    if event == .pgm {
      // Request
      operatorDic["request"] = playerMedia?.requestURL ?? ""
      // Response
      if let response = playerMedia?.responseJSON {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: response, options: []) else { return [:] }
        let responseJson = String(data: jsonData, encoding: .utf8)
        operatorDic["response"] = responseJson
        operatorDic["status"] = ((playerMedia?.responseJSON?["status"] as? Int) ?? 0) == 200 ? 1 : 0
      } else {
        operatorDic["response"] = ""
        operatorDic["status"] = 0
      }
    } else {
      operatorDic["request"] = ""
      operatorDic["response"] = ""
      operatorDic["status"] = 0
    }
    
    if let materialID = playerMedia?.media?.meterialId() {
      operatorDic["material_id"] = materialID
    }
    
    operatorDic["groupid"] = playerMedia?.group?.group_id
    
    if let selectedLanguage = dashboardConfiguration?.languageSelected {
      operatorDic["lenguage"] = selectedLanguage.labelLarge
    }
    
    if let videoUrl = playerMedia?.media?.videoUrl {
      operatorDic["video_url"] = videoUrl.absoluteString
    }
    
    if let streamType =  playerMedia?.streamType {
      operatorDic["stream_type"] = streamType
    }
    
    //Seek parameters
    if startTime != 0 && endTime != 0 {
      let seekTimeInterval:TimeInterval = endTime - startTime
      let seekTimeSeconds = lroundf(Float(seekTimeInterval))
      let startTimeInSeconds = lroundf(Float(startTime))
      let endTimeInSeconds = lroundf(Float(endTime))
      
      operatorDic["seek_start"] = String.timeFormatted(startTimeInSeconds)
      operatorDic["seek_end"] = String.timeFormatted(endTimeInSeconds)
      operatorDic["seek_time"] = seekTimeSeconds
    } else {
      operatorDic["seek_start"] = ""
      operatorDic["seek_end"] = ""
      operatorDic["seek_time"] = 0
    }
    //Quality parameters
    operatorDic["bitrate"] = bitrate
    // Check if error exists
    if let error = error {
      var failData:[String:Any] = [:]
      // Set error
      failData["msg"] = error.localizedDescription
      if let errors = playerMedia?.responseJSON?["errors"] {
        failData["stacktrace"] = errors
      }
      operatorDic["faildata"] = failData
    }
    // Set operator object
    params["operator"] = operatorDic
    return params
  }
  
  fileprivate func parameters(for httpHeaders: [String: String]) -> [String: String] {
    let defaultValue = "default"
    var headersDictionary:[String: String] = [:]
    
    // Set X-Cache value and node
    if let xCache = httpHeaders["X-Cache"] {
      //Get node. Regexp check
      let node = xCache.getRegexpMatch(patthern: "(.*from )(.*)( \\(Akamai.*)", andIndex: 2)
      // Set node value
      headersDictionary["node"] = node != "" ? node : defaultValue
      // Set X-Cache value
      headersDictionary["X-Cache"] = xCache
    } else {
      headersDictionary["node"]    = defaultValue;
      headersDictionary["X-Cache"] = defaultValue
    }
    
    // Set X-Cache-Remote value
    if let xCacheRemote = httpHeaders["X-Cache-Remote"] {
      let url = xCacheRemote.getRegexpMatch(patthern: "(.*from )(.*)( \\(Akamai.*)", andIndex: 2)
      // Set URL value
      headersDictionary["URL"] = url != "" ? url : defaultValue
      // Get URL.
      headersDictionary["X-Cache-Remote"] = xCacheRemote
    }
    
    // Set X-Cache-Key value
    if let xCacheKey = httpHeaders["X-Cache-Key"] {
      headersDictionary["X-Cache-Key"] = xCacheKey
    }
    // Set X-Cache-ID value
    if let xCacheID = httpHeaders["X-Cache-ID"] {
      headersDictionary["X-Cache-ID"] = xCacheID;
    }
    return headersDictionary
  }
  
  //MARK: - VideoPlayerWrapperListener
  
  /**
   * Important note: This method is invoked on new playbacks and when changing of content.
   */
  public func videoPlayerDidStartPlaying() {
    /* ClaroDashboard start */
    //Quality change events don´t send start
    if isQualityChange {
      guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
      ClaroDashboard.shared.sendEvent(.start, playerMedia: playerMedia)
    }
    // change to false for future start events
    isQualityChange = false
  }
  
  public func videoPlayerDidPause() {
    if !didManuallyPauseHappen && IS_IPAD() {
      didManuallyPauseHappen = true
      guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
      ClaroDashboard.shared.sendEvent(.pause, playerMedia: playerMedia)
    }
  }
  
  public func videoPlayerDidStartBuffering() {
    /* ClaroDashboard buffering_start */
    guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
    ClaroDashboard.shared.sendEvent(.bufferingStart, playerMedia: playerMedia)
  }
  
  public func videoPlayerDidEndBuffering() {
    /* ClaroDashboard buffering_end */
    guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
    ClaroDashboard.shared.sendEvent(.bufferingEnd, playerMedia: playerMedia)
  }
  
  public func videoPlayerDidResumePlaybackManually() {
    didManuallyPauseHappen = false
    /* ClaroDashboard resume */
    guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
    ClaroDashboard.shared.sendEvent(.resume, playerMedia: playerMedia)
  }
  
  public func videoPlayerDidSeekToTime(_ timeInSeconds:TimeInterval, startTime:TimeInterval) {
    //if manually seek happend dont send seek event
    if didManuallySeekHappen {
      didManuallySeekHappen = false
    }
  }
  
  public func videoPlayerDidFail(error:Error) {
    didErrorHappen = true
    /* ClaroDashboard error */
    ClaroDashboard.shared.sendEvent(.error, error: error)
  }
  
  /* Endtime reached */
  public func videoPlayerDidPlayerItemPlayToEndTime() {
    /* ClaroDashboard end */
    guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
    ClaroDashboard.shared.sendEvent(.end, playerMedia: playerMedia)
    didEndContent = true
  }
  
  public func videoPlayerDidChangeClockTime(_ seconds:TimeInterval) {
    hlsPlayerCurrentTime = seconds
  }
  
  //MARK: - MediaPlayerOverlay Delegate
  public func playerDidTapPlayButton() {
    // Do something if needed
    didManuallyPauseHappen = true
    guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
    ClaroDashboard.shared.sendEvent(.pause, playerMedia: playerMedia)
  }
  
  public func playerDidTimeSliderEndDragging(_ sliderValue:CGFloat) {
    // Get slider value at the time user ends dragging
    let duration:CGFloat = CGFloat(dashboardConfiguration?.totalStreamTime ?? 0)
    let seekTime:TimeInterval = TimeInterval(nearbyintf(floorf(Float(sliderValue * duration))))
    // Send ClaroDashboard seek
    ClaroDashboard.shared.sendSeekManuallyEvent(.seek, startTime: hlsPlayerCurrentTime, endTime: seekTime)
  }
  
  public func playerDidTapForwardButton() {
    /* ClaroDashboard Forward30 */
    ClaroDashboard.shared.sendSeekManuallyEvent(.forward30, startTime: hlsPlayerCurrentTime, endTime: (hlsPlayerCurrentTime + playerTimeSkip))
  }
  
  public func playerDidTapBackwardButton() {
    /* ClaroDashboard Rewind30 */
    ClaroDashboard.shared.sendSeekManuallyEvent(.rewind30, startTime: hlsPlayerCurrentTime, endTime: (hlsPlayerCurrentTime - playerTimeSkip))
  }
  
  //MARK: - sendTrackRequestForOptionListController
  public func sendDashboardRequest(listKind:String, selectedOption: CVListOption) {
    if listKind == "qualities" {
      sendChangeQualityEvents(selectedOption: selectedOption)
    } else if listKind == "languages" {
      sendChangeLanguageEvents(selectedOption: selectedOption)
    } else if listKind == "seasonEpisodes" {
      sendChangeEpisodeEvent()
    }
  }
  
  public func sendChangeQualityEvents(selectedOption: CVListOption) {
    isQualityChange = true
    // Validate option changed
    let oldQuality = dashboardConfiguration?.currentQualitySelected
    
    if let idString = oldQuality?.id, idString == selectedOption.optionID {
      // Get new quality dictionary from mediaConfiguration
      guard let newQuality = dashboardConfiguration?.qualities?.first(where: { (quality) -> Bool in
        return quality.id == selectedOption.optionID
      }) else { return }
      // ClaroDashboard quality
      guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
      ClaroDashboard.shared.sendEvent(.quality, playerMedia: playerMedia)
      // Quality up
      let oldIntId = Int(oldQuality?.id ?? "0") ?? 0
      let newIntId = Int(newQuality.id) ?? 0
      if oldIntId < newIntId {
        // ClaroDashboard quality_up
        ClaroDashboard.shared.sendEvent(.qualityUp, playerMedia: playerMedia)
      } else {
        // ClaroDashboard quality_down
        ClaroDashboard.shared.sendEvent(.qualityDown, playerMedia: playerMedia)
      }
      // ClaroDashboard bitrate
      if newIntId > 0 {
        ClaroDashboard.shared.sendBitrateEvent(bitrate: newIntId, playerMedia: playerMedia)
      }
    }
  }
  
  public func sendChangeLanguageEvents(selectedOption:CVListOption) {
    // ClaroDashboard language
    guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
    ClaroDashboard.shared.sendEvent(.language, playerMedia: playerMedia)
    
    if !(dashboardConfiguration?.isMultipleAudio ?? false) {
      /* ClaroDashboard stop */
      ClaroDashboard.shared.sendEvent(.stop, playerMedia: playerMedia)
    }
  }
  
  public func sendChangeEpisodeEvent() {
    /* ClaroDashboard episode */
    guard let playerMedia = dashboardConfiguration?.playerMedia else { return }
    ClaroDashboard.shared.sendEvent(.episode, playerMedia: playerMedia, success: nil, failure: nil)
    /* ClaroDashboard stop */
    ClaroDashboard.shared.sendEvent(.stop, playerMedia: playerMedia, success: nil, failure: nil)
  }
}
