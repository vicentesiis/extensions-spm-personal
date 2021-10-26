//
//  Metadata+Configuration.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 17/10/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public class MetadataConfiguration {
  public var metadata: Metadata?
  var region: String?
  public static let shared = MetadataConfiguration()
  
  private init() {}
  
  public func setLocalConfiguration(metadata: Metadata?, region: String) {
    self.metadata = metadata
    self.region = region
  }
}

public extension Metadata {
  //MARK: Var
  static var regionCanSuscribe: Bool {
    if  let region = MetadataConfiguration.shared.region {
      return region == "mexico"
    }
    return false
  }
  
  static var filterlist: String {
    guard let filterList = MetadataConfiguration.shared.metadata?.filterList else { return "" }
    let filterListLocalized = filterList.localized()
    if let filterListForRegion = filterListLocalized[keyPath: "filterlist"] as? String {
      return filterListForRegion
    }
    return ""
  }
  
  static var isExternalMetadataEnabled: Bool {
    if let externalMetadata = MetadataConfiguration.shared.metadata?.externalMetadata?.localized(),
       let enable = externalMetadata["enabled"] as? Bool {
      return enable
    }
    return false
  }
  
  static var sendUserIdParam: Bool {
    if let stickySession = MetadataConfiguration.shared.metadata?.stickySession?.localized(),
       let userId = stickySession["user_id"] as? Bool {
      return userId
    }
    return false
  }
  
  static var profilesEnabled: Bool {
    if let profilesConfiguration = MetadataConfiguration.shared.metadata?.profilesConfiguration?.localized(),
       let enable = profilesConfiguration["enable"] as? Bool {
      return enable
    }
    return false
  }
  
  static var socializationEnabled: Bool {
    if let socialConfiguration = MetadataConfiguration.shared.metadata?.socialConfiguration?.localized(),
       let enable = socialConfiguration["enable"] as? Bool {
      return enable
    }
    return false
  }
  
  static var sendPushSessionService: Bool {
    if let stickySession = MetadataConfiguration.shared.metadata?.stickySession?.localized(),
       let enable = stickySession["push_session"] as? Bool {
      return enable
    }
    return false
  }
  
  static var isFilterChannelsEnable: Bool {
    if let filterUnavailableChannels = MetadataConfiguration.shared.metadata?.filterUnavailableChannels?.localized(),
       let enable = filterUnavailableChannels["enabled_toggle"] as? Bool {
      return enable
    }
    return false
  }
  
  static var getExternalProvider: String? {
    if let externalMetadata = MetadataConfiguration.shared.metadata?.externalMetadata?.localized(),
       let externalProvider = externalMetadata["provider"] as? String {
      return externalProvider
    }
    return nil
  }
  
  static var isEpgChannelsEverywhereActive: Bool {
    guard let epgChannelsEverywhere = MetadataConfiguration.shared.metadata?.epgChannelsEverywhere?.localized(),
          let enable = epgChannelsEverywhere["enable"] as? Bool else {return false}
    return enable
  }
  
  static var showDeleteButtonContinueWatching: Bool {
    guard let newExperienceDict = getLocalDictionaryFor(key: "recent_activity_delete_button"),
          let enabled = newExperienceDict["enable"] as? Bool else {return false}
    return enabled
  }
  
  static var useSesionValidation: Bool {
    guard let sessionValidation = getSessionValidationDic(),
          let enabled = sessionValidation["enable"] as? Bool else {return false}
    return enabled
  }
  
  static var sesionValidationTime: TimeInterval? {
    guard let sessionValidation = getSessionValidationDic(),
          let time = sessionValidation["time"] as? TimeInterval else { return nil }
    return time
  }
  
  static var mailValidationLimit: Int? {
    guard let sessionValidation = userMailValidation(),
          let limit = sessionValidation["limit"] as? Int else { return nil }
    return limit
  }
  
  static var showDeleteContinueWatching: Bool {
    guard let newExperienceDict = getLocalDictionaryFor(key: "recent_activity_delete_button"),
    let enabled = newExperienceDict["enable"] as? Bool else {return false}
    return enabled
  }
  
  // Preload validator
  static var isPreloadActive: Bool {
    guard let preloadDic = getLocalDictionaryFor(key: "preload_asset_active"),
          let enabled = preloadDic["enable"] as? Bool else { return false }
    return enabled
  }
  
  /** Reminders interval in minutes 1m =  `60s` */
  static var remindersInterval: TimeInterval { TimeInterval(sentinelRemindersInterval) * 60 }
  /** minutes literal 1m = yyhh`m100`   default 10 min.*/
  static var remindersGraceTime: Int { sentinelRemindersInterval * 100 }
  
  fileprivate static var sentinelRemindersInterval: Int {
    guard let intervalStr = MetadataConfiguration.shared.metadata?.rawValue?["sentinel_reminders_interval"] as? String, let interval = Int(intervalStr)
    else { return Int(CVTimeConstants.defaultRemindersInterval) }
    return interval
  }
  
  static var getMiniEPGAutoHide: Double {
    guard let additionalsSecondsDic = getLocalDictionaryFor(key: "mini_epg_auto_hide_seconds"),
          let seconds = additionalsSecondsDic["time"] as? Int
    else { return CVTimeConstants.defaultControlsAutoHide }
    return Double(seconds)
  }

  static var skipIntroAutoHide: Double {
    guard let additionalsSecondsDic = getLocalDictionaryFor(key: "additional_autoHide_skipIntro_seconds"),
          let seconds = additionalsSecondsDic["time"] as? Int
    else { return CVTimeConstants.defaultAutoHideSkipIntro }
    return Double(seconds)
  }
  
  static var controlsAutoHide: Double {
#if DEBUG
    return 20
#else
    guard let controlsAutoHideDic = getLocalDictionaryFor(key: "playerControls_auto_hide_time"),
          let seconds = controlsAutoHideDic["time"] as? Int
    else { return CVTimeConstants.defaultControlsAutoHide }
    return Double(seconds)
#endif
  }
  
  static var getAlertLiveAutoHiden: Int {
    guard let autoHiddeSkipDic = getLocalDictionaryFor(key: "alert_autoHideTime"),
          let autoHiddeDefault = autoHiddeSkipDic["playing_time"] as? Int else {
            return Int(CVTimeConstants.defaultUtoHideAlertLive)
          }
    return autoHiddeDefault
  }
  
  static var getPasswordTooltipAutoHiden: Int {
    guard let autoHiddeSkipDic = getLocalDictionaryFor(key: "alert_autoHideTime"),
          let autoHiddeDefault = autoHiddeSkipDic["time"] as? Int else {
            return Int(CVTimeConstants.defaultUtoHideAlertLive)
          }
    return autoHiddeDefault
  }
  
  static var getKidsTooltipAutoHiden: Int {
    guard let autoHiddeSkipDic = getLocalDictionaryFor(key: "alert_autoHideTime"),
          let autoHiddeDefault = autoHiddeSkipDic["profiles_selectKids"] as? Int else {
            return Int(CVTimeConstants.defaultAutoHideKidsTooltip)
          }
    return autoHiddeDefault
  }
  
  static var isTimeshiftEnable: Int { timeshiftNpvrConfiguration(for: "timeshift") }
  static var isNpvrEnable: Int { timeshiftNpvrConfiguration(for: "npvr_button_record") }
  
  //MARK: Functions
  
  static func searchQuantity(type: CVSearchPredictiveType) -> [String: Any] {
    let defaultQuantity = type == .predictive ? 4 : 40
    let dictionary: [String: Any] = ["suggest": 1, "movies": defaultQuantity, "series": defaultQuantity, "live_channels": defaultQuantity, "events": defaultQuantity, "genres": 1, "talents": defaultQuantity, "users": defaultQuantity, "unavailables": 0]
    
    if let searchPriority = MetadataConfiguration.shared.metadata?.searchPriority?.localized() {
      if type == .predictive, let searchPriority = searchPriority["search_predictive_quantity"] as? [String: Any] {
        return searchPriority
      } else if let searchFullQuantity = searchPriority["search_full_quantity"] as? [String: Any] {
        return searchFullQuantity
      }
    }
    return dictionary
  }
  
  
  static func searchPriorityArray() -> [String]? {
    if let searchPriority = MetadataConfiguration.shared.metadata?.searchPriority?.localized(),
       let searchPriorityArray = searchPriority["searchPriority"] as? [String] {
      return searchPriorityArray
    }
    return nil
  }
  
  static func isChromecastEnabled(provideer: String)->Bool {
    guard let chromecast = MetadataConfiguration.shared.metadata?.chromecastBehaviour,
          let chromecastDict = chromecast.toDictionary()?.localized(),
          let disabled = chromecastDict["provider_disabled"] as? [String] else { return true}
    return !disabled.contains(provideer)
  }
  
  static func getTalentRolePriority(provider: String) -> [String]? {
    if let talentRolePriority = MetadataConfiguration.shared.metadata?.talentRolePriority?.localized(),
       let providerPriority = talentRolePriority[provider] as? [String]  {
      return providerPriority
    }
    return nil
  }
  
  static func getMonthBy(index: Int) -> String? {
    if let months = MetadataConfiguration.shared.metadata?.months?.localizedArray(),
       months.count > 0, index <= months.count {
      return months[index - 1]
    }
    /// If metadata dont has a value get current Month from date
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    let nameOfMonth = dateFormatter.string(from: now)
    return nameOfMonth
  }
  
  //Suport for Objc Params
  static func getMediaCertificate() -> [String: Any]? {
    return MetadataConfiguration.shared.metadata?.mediaCertificate?.localized()
  }
  
  static func getEpgEventSafeTime() -> [String: Any]? {
    return MetadataConfiguration.shared.metadata?.epgEventSafeTime?.localized()
  }
  
  static func getPushNotificationConfig() -> [String: Any]? {
    return MetadataConfiguration.shared.metadata?.pushNotificationConfig?.localized()
  }
  
  static func getTenantCodeConfiguration() -> [String: Any]? {
    return MetadataConfiguration.shared.metadata?.tenantCodeConfiguration?.localized()
  }
  
  static func getHiddenConfirmTransConfig() -> [String: Any]? {
    return MetadataConfiguration.shared.metadata?.hiddenConfirmTransConfig?.localized()
  }
  
  static func getPurchaseFlowConfig() -> [String: Any]? {
    return MetadataConfiguration.shared.metadata?.purchaseFlowConfig?.localized()
  }
  
  static func getTransactionalConfiguration() -> [String: Any]? {
    guard let transactionalConfiguration = MetadataConfiguration.shared.metadata?.transactionalConfiguration?.localized(),
          let subscriptions = transactionalConfiguration["suscription"] as? [String:Any],
          let products = subscriptions["products"] as? [String:Any] else {return nil}
    return products
  }
  
  fileprivate static func getLocalDictionaryFor(key: String) -> [String:Any]? {
    guard let keyValue = MetadataConfiguration.shared.metadata?.rawValue?[key] as? String,
          let keyDict = keyValue.toDictionary()?.localized() else { return nil }
    return keyDict
  }
  
  static func canShowConfirmAlert(key: String?) -> Bool {
    guard let transactionalConfiguration = Metadata.getHiddenConfirmTransConfig() else { return true }
    if let hiddenList = transactionalConfiguration["hidden_list"] as? [String], let key = key {
      return !hiddenList.contains(key)
    }
    if let all = transactionalConfiguration["all"] as? String {
      return !all.boolValue
    }
    return true
  }
  
  static func posterTitleConfiguration() -> [String:Any]? {
    guard let titleConfigDic = getLocalDictionaryFor(key: "poster_title_configuration") else {return nil}
    return titleConfigDic
  }
  
  // Session validator
  fileprivate static func getSessionValidationDic() -> [String:Any]? {
    guard let sessionDic = getLocalDictionaryFor(key: "session_validation_timer") else {return nil}
    return sessionDic
  }
  
  //User mail validation for Complete data
  fileprivate static func userMailValidation() -> [String: Any]? {
    guard let sessionDic = getLocalDictionaryFor(key: "user_mail_validation") else {return nil}
    return sessionDic
  }
  
  //Validation for login button options
  static func getLoginAccessOptions() -> [String]? {
    guard let loginAccessDic = getLocalDictionaryFor(key: "login_register_access_options"),
          let loginOptions = loginAccessDic["login"] as? [[String:Any]] else {return nil}
    var optionsToShow = [String]()
    for option in loginOptions {
      if let active = option["active"] as? String,
         let id = option["id"] as? String,
         active.boolValue {
        optionsToShow.append(id)
      }
    }
    return optionsToShow
  }
  
  private static func timeshiftNpvrConfiguration(for key: String) -> Int {
    guard let configDic = getLocalDictionaryFor(key: "timeshift_npvr_configuration"),
          let config = configDic[key] as? [String: Any],
          let enable = config["enable"] as? Bool else { return 1 }
    return enable ? 1 : 0
  }
}
