//
//  MusicTrackHandler.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 11/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation
import UIKit

public protocol MusicTrackHandlerDelegate: AnyObject {
  func sendTrackEvent(uri: String, params:[String:Any]?, completion: @escaping(Result<Bool, NetworkError>)->Void)
  func getDeviceParametersTracking(baseParameters:[String:Any]?) -> [String:Any]?
}


public final class MusicTrackHandler:TrackHandler {

  fileprivate var time = Timer()
  fileprivate var isTimerRunning = false
  fileprivate var effectiveTime:Int = 0
  fileprivate var isInPause:Bool = false
  fileprivate var isStarter: Bool = true
  
  public weak var musicDelegate: MusicTrackHandlerDelegate?
  
  public override func performRequest(for requestType: CVTrackRequestType, currentPlaybackTime: CGFloat, completionBlock block: ((Bool, [String : Any]?, Error?) -> Void)?) {
    // Check connection
    let isReachable = delegate?.isReachable() ?? false
    guard isReachable else {
      block?(true,nil,nil)
      return
    }
    
    var trackUrlString = ""
    var trackType = ""
    var listParamName = "playlist"
    switch requestType {
      case .trackTick:
        trackUrlString = trackConfiguration.playerMedia?.tracking?.tickURL ?? ""
        trackType = "tick"
      case .trackCompletion:
        trackUrlString = trackConfiguration.playerMedia?.tracking?.completionURL ?? ""
        trackType = "success"
        listParamName =  "list_id"
      case .trackPlayerError:
        trackUrlString = trackConfiguration.playerMedia?.tracking?.errorURL ?? ""
        trackType = "error"
      default:
        trackUrlString = ""
        trackType = "none"
    }
    trackUrlString = trackUrlString.replacingOccurrences(of: "&amp;", with: "&")
    guard trackUrlString != "" else {
      block?(true,nil,nil)
      return
    }
    
    if let listId = trackConfiguration.playerMedia?.media?.challengeDictionary?["playlistId"] as? String {
      trackUrlString = trackUrlString + "\(listParamName)=\(listId)&track=\(trackType)"
    }
   
    if requestType == .trackCompletion,
       let parameter =  musicDelegate?.getDeviceParametersTracking(baseParameters:getTrackingSuccessParams()) {
      /* Realizar peticion de tracking */
      musicDelegate?.sendTrackEvent(uri: trackUrlString, params: parameter) { (result) in
        switch result {
        case .success(let success):
          self.effectiveTime = 0
          self.isStarter = false
          block?(success,nil,nil)
        case .failure(let error):
          block?(true,nil,error)
        }
      }
    } else {
      musicDelegate?.sendTrackEvent(uri: trackUrlString, params: nil) { (result) in
        switch result {
        case .success(let success):
          block?(success,nil,nil)
        case .failure(let error):
          block?(true,nil,error)
        }
      }
    }
  }
  
  public override func videoPlayerPerformAction(_ type: CVTrackRequestType, at currentTime: Double) {
    super.videoPlayerPerformAction(type, at: currentTime)
    
    if type == .trackResume {
      self.isInPause = false
      self.startTimer()
    } else if type == .trackPause {
      self.isInPause = true
      self.invalidTime()
    }
  }
  
  
  public override func videoPlayerDidSeek(toTime timeInSeconds: TimeInterval, startTime startTimeInSeconds: TimeInterval) {
    super.videoPlayerDidSeek(toTime: timeInSeconds, startTime: startTimeInSeconds)
    self.invalidTime()
  }
  
  
  public override func videoPlayerDidPlayerItemPlayToEndTime(completion: (()->())?) {
    self.invalidTime()
    self.effectiveTime = 0
    completion?()
  }
  
  public override func sendTrackCompletion(completion: (()->())?) {
    performRequest(for: .trackCompletion, currentPlaybackTime: 0, completionBlock: nil)
  }
  
  public override func videoPlayerDidClose() {
    super.videoPlayerDidClose()
    invalidTime()
    sendTrackCompletion(completion: nil)
  }
  
  private func invalidTime() {
    time.invalidate()
  }
  
  private func startTimer() {
    if !time.isValid && !isInPause{
      time = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
  }
  
  @objc func updateTimer() {
    effectiveTime = effectiveTime + 1
  }
  
  fileprivate func getTrackingSuccessParams() -> [String:Any]? {
    guard let playerMedia = trackConfiguration.playerMedia,
      let tracking = playerMedia.tracking,
      let musicTrackSucces = tracking.trackSuccess,
      let body = musicTrackSucces.body,
      let device = body["device"] as? [String: Any],
      var data =  musicTrackSucces.data,
      var phonograms = data["phonograms"] as? [String: Any],
      var media = phonograms.values.first as? [String: Any],
      let phonogramsKey = phonograms.keys.first,
      var event = media["event"] as? [String: Any] else { return nil }
    
    media["duration"] = "\(effectiveTime)"
    event["is_starter"] = isStarter ? "1" : "0"
    media["event"] = event
    phonograms[phonogramsKey] = media
    data["phonograms"] = phonograms
    return ["device": device, "data": data]
  }

}
