//
//  TrackHandler.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 11/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TrackHandlerDelegate: AnyObject {
  @objc optional func updateDownload(playerMedia: PlayerMedia, playbackTime: Int)
  func isReachable() -> Bool
}


public class TrackHandler: NSObject {
  //Private
  /**
  Sometimes the method "sendTrackStop" is call after completion movie. This caused that track is invalidate.
  */
  private var isTrackCompletionChanged  : Bool = false
  private var isTrackQualityChanged     : Bool = false
  private var isTrackSeekChanged        : Bool = false
  private var isEpisodeChanged          : Bool = false
  private var isDubSubChange            : Bool = false
  private var isLiveEvent               : Bool = false
  private var lastTrackType: CVTrackRequestType = .none
  private var isSingleAudio           : Bool = false
  private var comeToOptions             : Bool = false
  
  //Public
  /**
   The model data of current player.
   */
  public var trackConfiguration: TrackMediaConfiguration
  public var hlsPlayerCurrentTime:TimeInterval = 0
  public weak var delegate: TrackHandlerDelegate?
  
  //MARK: - Init
  public init(trackConfiguration: TrackMediaConfiguration) {
    self.trackConfiguration = trackConfiguration
    isTrackCompletionChanged = false
  }
  
  //MARK:  - Common
  deinit {
    NotificationCenter.default.removeObserver(self, name: UIApplication.willTerminateNotification, object: nil)
  }
  
  //MARK: - Notification Handlers
  private func registerApplicationNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIApplication.willTerminateNotification, object: nil)
    //Did enter background active
    NotificationCenter.default.addObserver(self, selector: #selector(handleApplicationWillTerminateNotification), name: UIApplication.willTerminateNotification, object: nil)
  }
  
  @objc private func handleApplicationWillTerminateNotification(notification:Notification) {
    if !isTrackCompletionChanged {
      sendTrackStop()
    }
  }
  
  //MARK: - Private
  public func updateOfflinePlaybackIfNeeded(time:Int) {
    // Update offline playback
    if let playerMedia = trackConfiguration.playerMedia,
       trackConfiguration.isOfflinePlayback {
      delegate?.updateDownload?(playerMedia: playerMedia, playbackTime: time)
    }
  }
  
  //MARK: - VideoPlayerWrapper Listener SwiftPlayer
  public func videoPlayerPerformAction(_ type: CVTrackRequestType, at currentTime: Double) {
    performRequest(for: type, currentPlaybackTime: CGFloat(currentTime), completionBlock: nil)
  }
  
  public func videoPlayerPerformAction(_ type: CVTrackRequestType, at currentTime: Double, with pictureInPicture: Bool) {
    performRequest(for: type, currentPlaybackTime: CGFloat(currentTime), completionBlock: nil)
  }
  
  public func videoPlayerDidStartPlaying(at currentTime: Double) {
    // IMPORTANT:
    //  TrackHandler is responsible to send events when a user interacts with player controls like resume, language, quality, seek bar or episode changed and player events like start, stop or complete a playback, based on this, we need to create flags to stop send automatic player events, because derived to the bussines rules we need to specify certain flows more info visit https://dlatvarg.atlassian.net/wiki/spaces/DAMCO/pages/200027168/Claro+video+-+Tracking+y+attach
    // Remember to set this property to false before call track/view, this flag is used to not send track/stop after track/completion occurs
    isTrackCompletionChanged = false
    // If player starts playing for the first time, send track/view
    // If player changed the episode, send track/view
    // If a track/qualitychanged was executed don't send track/view
    if !isTrackQualityChanged || isEpisodeChanged {
      performRequest(for: .trackView, currentPlaybackTime: CGFloat(currentTime), completionBlock: nil)
      hlsPlayerCurrentTime = currentTime
    }
    // Rember to reset values after send track/view
    isEpisodeChanged = false
  }
  
  public func videoPlayerDidFail(at currentTime: Double) {
    isTrackCompletionChanged = false
    let time = currentTime > 0 ? currentTime : hlsPlayerCurrentTime
    performRequest(for: .trackPlayerError, currentPlaybackTime: CGFloat(time), completionBlock: nil)
  }

  //MARK: - Seek event
  public func videoPlayerDidSeek(toTime timeInSeconds: TimeInterval, startTime startTimeInSeconds: TimeInterval) {
    if isTrackSeekChanged {
      performRequest(for: .trackSeek, currentPlaybackTime: CGFloat(timeInSeconds), completionBlock: nil)
    }
    isTrackCompletionChanged = false
    // Updated Offline playback if it's neccesary
    // Send zero to restart the player
    updateOfflinePlaybackIfNeeded(time: Int(timeInSeconds))
  }
  
  //MARK: - VideoPlayerWrapper Listener
  public func videoPlayerDidPlayerItemPlayToEndTime(completion: (()->())?) {
    sendTrackCompletion(completion: completion)
    // Updated Offline playback if it's neccesary
    // Send zero to restart the player
    updateOfflinePlaybackIfNeeded(time: 0)
  }
  
  public func videoPlayerDidClose() {
   sendTrackStop()
  }
  
  public func videoPlayerDidChangeClockTime(_ seconds: TimeInterval) {
    hlsPlayerCurrentTime = seconds
  }
  
  public func playerDidTapForwardButton() {
    isTrackSeekChanged = true
  }
  
  public func playerDidTapBackwardButton() {
    isTrackSeekChanged = true
  }
  
  public func playerDidStartSeek() {
    isTrackSeekChanged = true
  }
  
  //MARK: - Public
  /**
   @brief Perform request to trackStop
   */
  public func sendTrackStop(onCompletion: (()->())? = nil) {
    if !trackConfiguration.isTrailer {
      performRequest(for: .trackStop, currentPlaybackTime: CGFloat(hlsPlayerCurrentTime), completionBlock: { _,_,_ in
        onCompletion?()
      })
      // Save the update Offline playback
      updateOfflinePlaybackIfNeeded(time: Int(hlsPlayerCurrentTime))
      hlsPlayerCurrentTime = 0.0
    } else {
      onCompletion?()
    }
  }
  
  public func sendChangeChannel(onCompletion: (()->())?) {
    isLiveEvent = true
    performRequest(for: .trackStop, currentPlaybackTime: CGFloat(hlsPlayerCurrentTime), completionBlock: { (_, _, _) in
      onCompletion?()
    })
  }
  
  /**
   @brief Perform request to trackCompletion
   */
  public func sendTrackCompletion(completion: (()->())?) {
    isTrackCompletionChanged = true
    if !trackConfiguration.isTrailer {
      performRequest(for: .trackCompletion, currentPlaybackTime: CGFloat(hlsPlayerCurrentTime), completionBlock: {_,_,_ in
        completion?()
      })
    } else {
      completion?()
    }
  }
  
  /**
   @brief Perform request to trackCredits
   */
  public func sendTrackCredits() {
    if !trackConfiguration.isTrailer {
      performRequest(for: .trackCredits, currentPlaybackTime: CGFloat(hlsPlayerCurrentTime), completionBlock: nil)
    }
  }

  /**
   @brief Perform request to trackDownload
   */
  public func sendTrackDownload() {
    if !trackConfiguration.isTrailer {
      performRequest(for: .trackDownload, currentPlaybackTime: CGFloat(hlsPlayerCurrentTime), completionBlock: nil)
    }
  }

  /**
   @brief Perform request to trackTick
   */
  public func sendTrackTick(withTime time:TimeInterval) {
    if !trackConfiguration.isTrailer {
      performRequest(for: .trackTick, currentPlaybackTime: CGFloat(hlsPlayerCurrentTime), completionBlock: nil)
    }
  }
  
  /**
   @brief Based on CVOptionListKind performs a request
   @param optionListKind option selected
   */
  public func sendTrackRequest(forOption listKind: String, selectedOption: CVListOption) {
    
    // Send track/stop after a change occurs only for single audio
    var requestType:CVTrackRequestType!
    switch listKind {
      case "qualities":
        requestType = .trackQualityChange
        isTrackQualityChanged = true
      case "languages":
        isDubSubChange = true
        requestType = .trackDubSubChange
      case "seasonEpisodes":
        requestType = .trackEpisodeChange
        sendTrackStop()
        isEpisodeChanged = true
        comeToOptions = true
      default:
        // Nothing to do
        return
    }
    
    performRequest(for: requestType,
                   currentPlaybackTime: CGFloat(hlsPlayerCurrentTime)) { [weak self] (success, dict, error) in
      guard let self = self else { return }
      // Send track/stop after send track request
      if requestType == CVTrackRequestType.trackDubSubChange {
        // Get new OptionLanguage from playerMedia langOptions
        let languageOptions = self.trackConfiguration.playerMedia?.group?.extended?.media.languageFormatOptions
        // Get OptionLanguage selected
        let newLanguageOption = languageOptions?.filter({ (language) -> Bool in
          return language.contentId == selectedOption.optionID
        }).first
        if let newLanguage = newLanguageOption {
          if !newLanguage.isMultipleAudio() {
            self.isSingleAudio = !newLanguage.isMultipleAudio()
            self.sendTrackStop()
          }
        }
      }
    }
  }

  /**
   @brief Perform request trackStart for reload in Live
   */
  public func sendTrackStartForReload() {
    isTrackCompletionChanged = false
    performRequest(for: .trackView, currentPlaybackTime: CGFloat(hlsPlayerCurrentTime), completionBlock: nil)
  }

  //MARK: - Request Handler
  public func performRequest(for requestType: CVTrackRequestType, currentPlaybackTime: CGFloat, completionBlock block: ((Bool, [String : Any]?, Error?) -> Void)?) {
    guard isValidTrack(currentTrack: requestType) else {
      lastTrackType = requestType
      block?(true, nil, nil)
      return
    }
    lastTrackType = requestType
    isLiveEvent = false
    let isReachable = delegate?.isReachable() ?? false
    if !isReachable {
      block?(true, nil, nil)
      return
    }
   
    if (trackConfiguration.isTrailer && (requestType != CVTrackRequestType.trackStop)) {
      block?(true, nil, nil)
      return
    }
    
    if (trackConfiguration.playerMedia?.tracking == nil) && requestType != CVTrackRequestType.trackDownload {
      print("Error: nodo tracking_list no disponible en playerdata!!!")
      block?(true, nil, nil)
      return
    }
    
    let registerCurrentPlaybackTime:CGFloat = currentPlaybackTime

    var trackUrlString:String? = nil
    switch requestType {
    case .trackView:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.viewURL
    case .trackCompletion:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.completionURL
    case .trackDubSubChange:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.dubsubchangeURL
    case .trackEpisodeChange:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.episodechangeURL
    case .trackPause:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.pauseURL
    case .trackPlayerError:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.errorURL
    case .trackQualityChange:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.qualitychangeURL
    case .trackSeek:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.seekURL
    case .trackStop:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.stopURL
    case .trackTick:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.tickURL
    case .trackResume:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.resumeURL
    case .trackCredits:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.creditsURL
    case .trackDownload:
      trackUrlString = trackConfiguration.playerMedia?.tracking?.downloadURL
    default:
      break
    }
    
    guard var trackUrl = trackUrlString else {
      print("No hay URL para trackear CVTrackRequestType \(requestType)")
      block?(true, nil, nil)
      return
    }
    
    var trackingParameters:[String:Any] = [:]
    guard let group = trackConfiguration.playerMedia?.group else {
      block?(true, nil, nil)
      return
    }
    // Adding parameters
    switch requestType {
    case .trackView:
      // For Live we need to add tracking data send it from device/attach
      if trackConfiguration.isLive {
        // Addtional parameters
        trackingParameters = trackConfiguration.playerMedia?.tracking?.additionalTrackingParameters ?? [:]
        if trackConfiguration.isUserLogged {
          //Important remove old device_id
          trackUrl.removeValueToURL(valueToRemove: "device_id")
          trackingParameters["purchase_id"] = group.purchaseId
          trackingParameters["offer_id"] = group.offerId
        }
        trackingParameters["group_id"] = group.group_id
      }
    default:
      let playbackTime:Int = registerCurrentPlaybackTime.isNaN ? 0 : Int(ceilf(Float(registerCurrentPlaybackTime)))
      trackingParameters["timecode"] = playbackTime
      // For Live we need to add tracking data send it from device/attach
      if trackConfiguration.isLive && trackConfiguration.isUserLogged {
        trackingParameters["purchase_id"] = group.purchaseId
      }
    }
    // Add JSON format
    trackingParameters["format"] = "json"
    /* Realizar peticion de tracking */
    let environment = Environment(httpProtocol: .https, host: "", port: "")
    let playerServices = PlayerServices(environment: environment, baseParameters: trackingParameters)
    playerServices.sendTrackEvent(withURI: trackUrl) { (result) in
      switch result {
      case .success(let response):
        block?(true, response, nil)
      case .failure(let error):
        block?(true, nil, error)
      }
    }
  }
  
  //MARK: Private methods
  private func isValidTrack(currentTrack: CVTrackRequestType) -> Bool {
    let isLive = trackConfiguration.isLive
    if (lastTrackType == .trackView || lastTrackType == .trackSeek) && ![CVTrackRequestType.trackCredits, CVTrackRequestType.trackStop, CVTrackRequestType.trackEpisodeChange, CVTrackRequestType.trackDubSubChange, CVTrackRequestType.trackQualityChange, CVTrackRequestType.trackPause, CVTrackRequestType.trackTick].contains(currentTrack) {
      return currentTrack == .trackSeek || currentTrack == .trackView
    } else if isTrackQualityChanged {
      if currentTrack == .trackResume {
        isTrackQualityChanged = false
      }
      return currentTrack == .trackQualityChange
    } else if isTrackSeekChanged {
      if currentTrack == .trackResume {
        isTrackSeekChanged = false
      } else if currentTrack != .trackSeek {
        isTrackSeekChanged = false
        return true
      }
      return currentTrack == .trackSeek
    } else if isEpisodeChanged {
      if currentTrack == .trackEpisodeChange {
        return comeToOptions
      }else if lastTrackType == .trackEpisodeChange && currentTrack == .trackStop {
        return false
      }
      return true
    } else if isDubSubChange {
      if currentTrack == .trackResume {
        isDubSubChange = false
      } else if currentTrack == .trackStop && lastTrackType == .trackDubSubChange {
        return true
      } else if currentTrack == .trackView {
        return isSingleAudio
      } else if currentTrack == .trackStop {
        isDubSubChange = false
        return currentTrack != lastTrackType
      }
      return currentTrack == .trackDubSubChange
    } else if isTrackCompletionChanged && currentTrack == .trackStop {
      self.isTrackCompletionChanged = false
      return false
    } else if lastTrackType == currentTrack && ![CVTrackRequestType.trackSeek, CVTrackRequestType.trackView, CVTrackRequestType.trackTick].contains(currentTrack) {
      return false
    } else if isLive && (lastTrackType == .none || lastTrackType == .trackStop) {
      return false
    }
    return true
  }
}
