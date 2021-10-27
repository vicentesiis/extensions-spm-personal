//
//  Metadata+Parceable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 11/30/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

extension Metadata: Parceable {
  
  public static func parseObject(dictionary: [String : Any]) -> Result<Metadata, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      // here "jsonData" is the dictionary encoded in JSON data
      let metadata = try JSONDecoder().decode(Metadata.self, from: jsonData)
      if metadata.rawValue == nil {
        metadata.rawValue = dictionary
      }
      return .success(metadata)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}

extension Metadata: Codable {
  
  enum metadataKeys: String, CodingKey { // declaring our keys
    case akamaiClientIp = "akamai_client_ip"
    case akamaiConfigUrl = "akamai_config_url"
    case akamaiServerIp = "akamai_server_ip"
    case baseUrlWebservices = "base_url_webservices"
    case bufferInitial = "buffer_initial"
    case bufferTotal = "buffer_total"
    case briefDwnldsMaxlimit = "brief_dwnlds_maxlimit"
    case cacheExpiration = "cache_expiration"
    case chromecast = "chromecast"
    case chromecastId = "chromecast_id"
    case configUrl = "config_url"
    case customBaseUrl = "custom_base_url"
    case deviceConfiguration = "device_configuration"
    case devicesUrls = "devices_urls"
    case deviceTypeIdMapping = "device_type_id_mapping"
    case deviceYearFwUpdateType = "device_year_fw_update_type"
    case disclaimer = "disclaimer"
    case enableForcePlayerStream = "enable_force_player_stream"
    case facebookAppkey = "facebook_appkey"
    case facebookUrl = "facebook_url"
    case facebookUrlRegion = "facebook_url_region"
    case fallbackAirplayHlsEnabled = "fallback_airplay_hls_enabled"
    case forceDownloadcenter = "force_download_center"
    case forcePlayerStream = "force_player_stream"
    case generalTimeout = "general_timeout"
    case googleAnalyticsId = "google_analytics_id"
    case hdBadgesActive = "hd_badges_active"
    case headerInfoUrl = "header_info_url"
    case internetConnectionTimeout = "internet_connection_timeout"
    case internetConnectionUrl = "internet_connection_url"
    case internetConnectionVerificationInterval = "internet_connection_verification_interval"
    case isCss = "css"
    case navVisibility = "nav_visibility"
    case isGoogleAnalyticsEnabled = "google_analytics_enabled"
    case labelConfiguration = "label_configuration"
    case landingCachetime = "landing_cachetime"
    case licenserTimeout = "licenser_timeout"
    case maxApilevelMspr = "max_apilevel_mspr"
    case maxRetries = "max_retries"
    case maxVersionMspr = "max_version_mspr"
    case minApilevelMspr = "min_apilevel_mspr"
    case minVersionMspr = "min_version_mspr"
    case months = "months"
    case nwEnableForcePlayerStream = "new_enable_force_player_stream"
    case nwForcePlayerStream = "new_force_player_stream"
    case nwRelicActivated = "new_relic_activated"
    case nwRelicAppKey = "new_relic_app_key"
    case forceAppKey = "force_appkey"
    case openStoreLabelConfiguration = "open_store_label_configuration"
    case parseAppid = "parse_appid"
    case parseEnabled = "parse_enabled"
    case parseKey = "parse_clientkey"
    case passwordMaxLength = "password_max_length"
    case passwordMinLength = "password_min_length"
    case pinCodesLength = "pin_codes_length"
    case playerGetMediaMaxRetries = "player_get_media_max_retries"
    case playerGetMediaTimeBetweenRetries = "player_get_media_time_between_retries"
    case playerMaxRetries = "player_max_retries"
    case playerPausedSecondsoverlay = "player_paused_secondsoverlay"
    case playerTimeout = "player_timeout"
    case predictivesearchMinChars = "predictivesearch_min_chars"
    case prLicenseServer = "pr_license_server"
    case providersLabelConfiguration = "providers_label_configuration"
    case providersDetailPromoImg = "providers_detail_promo_img"
    case qualitychangeTimeout = "qualitychange_timeout"
    case regionalConfiguration = "regional_configuration"
    case regionalParameters = "regional_parameters"
    case ribbonEditCachetime = "ribbon_edit_cachetime"
    case ribbonEditLoadnumber = "ribbon_edit_loadnumber"
    case ribbonPrecacheCount = "ribbon_precache_count"
    case ribbonsMaxResults = "ribbons_max_results"
    case ribbonsUser = "ribbons_user"
    case ribbonsUserStringcommas = "ribbons_user_stringcommas"
    case ribbonUserCachetime = "ribbon_user_cachetime"
    case ribbonUserLoadnumber = "ribbon_user_loadnumber"
    case skipSeconds = "skip_seconds"
    case specialContentType1 = "special_content_type1"
    case specialContentType2 = "special_content_type2"
    case specialContentType3 = "special_content_type3"
    case specialContentType4 = "special_content_type4"
    case startBitrate = "startBitrate"
    case startBitrateEnabled = "startBitrate_enabled"
    case states = "states"
    case streamTypeLive = "stream_type_live"
    case telcelServiceNotAvailableMessage = "telcel_service_not_available_message"
    case timeLiveRequestPlayerDash = "time_live_request_player_dash"
    case timeLiveRequestPlayerHls = "time_live_request_player_hls"
    case timeLiveRequestPlayerHlsfrm = "time_live_request_player_hlsfrm"
    case timeLiveRequestPlayerHlsprm = "time_live_request_player_hlsprm"
    case timeLiveRequestPlayerSmooth = "time_live_request_player_smooth"
    case externalMetadata = "external_metadata"
    
    case translations = "translations"
    
    case ttlChannelsUserLive = "ttl_channels_user_live"
    case userFavoritesQuantity = "user_favorites_quantity"
    case webservicesProtocol = "webservices_protocol"
    case detailPromoImage = "detail_promo_img"
    case chromecastBehaviour = "chromecast_behaviour"
    case filterList = "byr_filterlist_configuration"
    case defaultNode = "defaultNode"
    case nodesConfiguration = "nodes_configuration"
    case dashboardURL = "logs_dashboard_url"
    
    case layoutNodeConfiguration = "layout_node_configuration"
    case mediaCertificate = "media_certificate"
    case qualitySelectorConfiguration = "quality_selector_configuration"
    case productPromoConfiguration = "product_promo_configuration"
    case downloadQualityConfiguration = "download_qualityconfig"
    case endplayerConfig = "endplayer_config"
    case transactionalConfiguration = "transactional_configuration"
    case livePPEAvailable = "live_ppe_available"
    case loginProviders = "login_providers"
    
    case socialLevels = "social_levels"
    case socializationEnabled = "socialization_enabled"
    case socializationGameId = "socialization_game_id"
    case whatsNew = "whatsnew_config"
    case epgEventSafeTime = "epg_event_safe_time"
    case purchaseButtonConfiguration = "purchase_button_configuration"
    case pushNotificationConfig = "push_notification_config"
    case skipIntroConfiguration = "skip_intro_configuration"
    case filterUnavailableChannels = "filter_unavailable_channels"
    case spritesConfiguration = "sprites_configuration"
    case isFilterChannelsEnable
    case talentRolePriority = "talent_role_priority"
    case loginRegisterOptions = "login_register_options"
    case defaultGroupIdChannel = "default_group_id_channel"
    case tenantCodeConfiguration = "tenant_code_configuration"
    case searchPriority = "search_priority"
    case mobilePhoneProvidersConfiguration = "mobile_phone_provider_configuration"
    case ssoPlaceholderErrors = "sso_placeholder_errors"
    case purchaseButtonColors = "purchasebutton_colors"
    case hiddenConfirmTransConfig = "hidden_confirm_trans_config"
    case purchaseFlowConfig = "purchase_flow_config"
    case stickySession = "sticky_session"
    case profilesConfiguration = "profiles_config"
    case socialConfiguration = "social_config"
    case youboraConfiguration = "youbora_options"
    case epgChannelsEverywhere = "epg_channels_everywhere"
    case rawValue
  }
  
  public convenience init(from decoder: Decoder) throws {
    self.init()
    
    let container = try decoder.container(keyedBy: metadataKeys.self) // defining our (keyed) container
    akamaiClientIp = try container.decode(String.self, forKey: .akamaiClientIp)
    akamaiConfigUrl = try container.decode(String.self, forKey: .akamaiConfigUrl)
    akamaiServerIp = try container.decode(String.self, forKey: .akamaiServerIp)
    baseUrlWebservices = try container.decode(String.self, forKey: .baseUrlWebservices)
    bufferInitial = try container.decode(Int.self, forKey: .bufferInitial)
    bufferTotal = try container.decode(Int.self, forKey: .bufferTotal)
    briefDwnldsMaxlimit = try container.decode(String.self, forKey: .briefDwnldsMaxlimit)
    cacheExpiration = try container.decode(Int.self, forKey: .cacheExpiration)
    chromecast = try container.decode(String.self, forKey: .chromecast)
    chromecastId = try container.decode(String.self, forKey: .chromecastId)
    configUrl = try container.decode(String.self, forKey: .configUrl)
    customBaseUrl = try container.decode(String.self, forKey: .customBaseUrl)
    let deviceConfigurationString = try container.decode(String.self, forKey: .deviceConfiguration)
    deviceConfiguration = ParserHelper.parse(data: deviceConfigurationString)
    devicesUrls = try container.decode(String.self, forKey: .devicesUrls)
    deviceTypeIdMapping = try container.decode(String.self, forKey: .deviceTypeIdMapping)
    deviceYearFwUpdateType = try container.decode(String.self, forKey: .deviceYearFwUpdateType)
    disclaimer = try container.decode(String.self, forKey: .disclaimer)
    enableForcePlayerStream = try container.decode(String.self, forKey: .enableForcePlayerStream)
    facebookAppkey = try container.decode(String.self, forKey: .facebookAppkey)
    facebookUrl = try container.decode(String.self, forKey: .facebookUrl)
    facebookUrlRegion = try container.decode(String.self, forKey: .facebookUrlRegion)
    fallbackAirplayHlsEnabled = try container.decode(Bool.self, forKey: .fallbackAirplayHlsEnabled)
    forceDownloadcenter = try container.decode(Bool.self, forKey: .forceDownloadcenter)
    forcePlayerStream = try container.decode(String.self, forKey: .forcePlayerStream)
    generalTimeout = try container.decode(Double.self, forKey: .generalTimeout)
    googleAnalyticsId = try container.decode(String.self, forKey: .googleAnalyticsId)
    hdBadgesActive = try container.decode(String.self, forKey: .hdBadgesActive)
    headerInfoUrl = try container.decode(String.self, forKey: .headerInfoUrl)
    internetConnectionTimeout = try container.decode(Int.self, forKey: .internetConnectionTimeout)
    internetConnectionUrl = try container.decode(String.self, forKey: .internetConnectionUrl)
    internetConnectionVerificationInterval = try container.decode(Int.self, forKey: .internetConnectionVerificationInterval)
    isCss = try container.decode(String.self, forKey: .isCss)
    let navVisibilityString = try container.decode(String.self, forKey: .navVisibility)
    navVisibility = ParserHelper.parse(data: navVisibilityString)
    isGoogleAnalyticsEnabled = try container.decode(Bool.self, forKey: .isGoogleAnalyticsEnabled)
    labelConfiguration = try container.decode(String.self, forKey: .labelConfiguration)
    landingCachetime = try container.decode(Int.self, forKey: .landingCachetime)
    licenserTimeout = try container.decode(Int.self, forKey: .licenserTimeout)
    maxApilevelMspr = try container.decode(Int.self, forKey: .maxApilevelMspr)
    maxRetries = try container.decode(Int.self, forKey: .maxRetries)
    maxVersionMspr = try container.decode(String.self, forKey: .maxVersionMspr)
    minApilevelMspr = try container.decode(Int.self, forKey: .minApilevelMspr)
    minVersionMspr = try container.decode(String.self, forKey: .minVersionMspr)
    let monthsString = try container.decode(String.self, forKey: .months)
    months = ParserHelper.parse(data: monthsString)
    nwEnableForcePlayerStream = try container.decode(Bool.self, forKey: .nwEnableForcePlayerStream)
    nwForcePlayerStream = try container.decode(String.self, forKey: .nwForcePlayerStream)
    nwRelicActivated = try container.decode(Bool.self, forKey: .nwRelicActivated)
    nwRelicAppKey = try container.decode(String.self, forKey: .nwRelicAppKey)
    forceAppKey = try container.decodeIfPresent(String.self, forKey: .forceAppKey)
    let openStoreLabelConfigurationString = try container.decode(String.self, forKey: .openStoreLabelConfiguration)
    openStoreLabelConfiguration = ParserHelper.parse(data: openStoreLabelConfigurationString)
    parseAppid = try container.decode(String.self, forKey: .parseAppid)
    parseEnabled = try container.decode(String.self, forKey: .parseEnabled)
    parseKey = try container.decode(String.self, forKey: .parseKey)
    passwordMaxLength = try container.decode(Int.self, forKey: .passwordMaxLength)
    passwordMinLength = try container.decode(Int.self, forKey: .passwordMinLength)
    pinCodesLength = try container.decode(Int.self, forKey: .pinCodesLength)
    playerGetMediaMaxRetries = try container.decode(Int.self, forKey: .playerGetMediaMaxRetries)
    playerGetMediaTimeBetweenRetries = try container.decode(Int.self, forKey: .playerGetMediaTimeBetweenRetries)
    playerMaxRetries = try container.decode(Int.self, forKey: .playerMaxRetries)
    playerPausedSecondsoverlay = try container.decode(Int.self, forKey: .playerPausedSecondsoverlay)
    playerTimeout = try container.decode(Int.self, forKey: .playerTimeout)
    predictivesearchMinChars = try container.decode(Int.self, forKey: .predictivesearchMinChars)
    prLicenseServer = try container.decode(String.self, forKey: .prLicenseServer)
    let providersLabelConfigurationString = try container.decode(String.self, forKey: .providersLabelConfiguration)
    providersLabelConfiguration = ParserHelper.parse(data: providersLabelConfigurationString)
    let providersDetailPromoImgString = try container.decode(String.self, forKey: .providersDetailPromoImg)
    providersDetailPromoImg = ParserHelper.parse(data: providersDetailPromoImgString)
    qualitychangeTimeout = try container.decode(Int.self, forKey: .qualitychangeTimeout)
    let regionalConfigurationString = try container.decode(String.self, forKey: .regionalConfiguration)
    regionalConfiguration = ParserHelper.parse(data: regionalConfigurationString)
    regionalParameters = try container.decode(String.self, forKey: .regionalParameters)
    ribbonEditCachetime = try container.decode(Int.self, forKey: .ribbonEditCachetime)
    ribbonEditLoadnumber = try container.decode(Int.self, forKey: .ribbonEditLoadnumber)
    ribbonPrecacheCount = try container.decode(Int.self, forKey: .ribbonPrecacheCount)
    ribbonsMaxResults = try container.decode(Int.self, forKey: .ribbonsMaxResults)
    ribbonsUser = try container.decode(String.self, forKey: .ribbonsUser)
    ribbonsUserStringcommas = try container.decode(String.self, forKey: .ribbonsUserStringcommas)
    ribbonUserCachetime = try container.decode(Int.self, forKey: .ribbonUserCachetime)
    ribbonUserLoadnumber = try container.decode(Int.self, forKey: .ribbonUserLoadnumber)
    skipSeconds = try container.decode(Int.self, forKey: .skipSeconds)
    specialContentType1 = try container.decode(String.self, forKey: .specialContentType1)
    specialContentType2 = try container.decode(String.self, forKey: .specialContentType2)
    specialContentType3 = try container.decode(String.self, forKey: .specialContentType3)
    specialContentType4 = try container.decode(String.self, forKey: .specialContentType4)
    startBitrate = try container.decode(Int.self, forKey: .startBitrate)
//    ///This one should be bool, but the service respond True in Upper
    if let startBitrateEnabledString = try? container.decode(String.self, forKey: .startBitrateEnabled) {
      startBitrateEnabled = Bool(startBitrateEnabledString.lowercased()) ?? false
    } else if let startBitrateEnabledBool = try? container.decode(Bool.self, forKey: .startBitrateEnabled) {
      startBitrateEnabled = startBitrateEnabledBool
    }
    states = try container.decode(String.self, forKey: .states)
    streamTypeLive = try container.decode(String.self, forKey: .streamTypeLive)
    telcelServiceNotAvailableMessage = try container.decode(String.self, forKey: .telcelServiceNotAvailableMessage)
    timeLiveRequestPlayerDash = try container.decode(Int.self, forKey: .timeLiveRequestPlayerDash)
    timeLiveRequestPlayerHls = try container.decode(String.self, forKey: .timeLiveRequestPlayerHls)
    timeLiveRequestPlayerHlsfrm = try container.decode(String.self, forKey: .timeLiveRequestPlayerHlsfrm)
    timeLiveRequestPlayerHlsprm = try container.decode(String.self, forKey: .timeLiveRequestPlayerHlsprm)
    timeLiveRequestPlayerSmooth = try container.decode(Int.self, forKey: .timeLiveRequestPlayerSmooth)
    let externalMetadataString = try container.decode(String.self, forKey: .externalMetadata)
    externalMetadata = ParserHelper.parse(data: externalMetadataString)
    let translationsString = try container.decode(String.self, forKey: .translations)
    translations = ParserHelper.parse(data: translationsString)
    ttlChannelsUserLive = try container.decode(Int.self, forKey: .ttlChannelsUserLive)
    userFavoritesQuantity = try container.decode(Int.self, forKey: .userFavoritesQuantity)
    webservicesProtocol = try container.decode(String.self, forKey: .webservicesProtocol)
    detailPromoImage = try container.decode(String.self, forKey: .detailPromoImage)
    chromecastBehaviour = try container.decode(String.self, forKey: .chromecastBehaviour)
    let filterListString = try container.decode(String.self, forKey: .filterList)
    filterList = ParserHelper.parse(data: filterListString)
    defaultNode = try? container.decodeIfPresent(String.self, forKey: .defaultNode)
    let nodesConfigurationString = try container.decode(String.self, forKey: .nodesConfiguration)
    nodesConfiguration = ParserHelper.parse(data: nodesConfigurationString)
    dashboardURL = try? container.decodeIfPresent(String.self, forKey: .dashboardURL)
    let layoutNodeConfigurationString = try container.decode(String.self, forKey: .layoutNodeConfiguration)
    layoutNodeConfiguration = ParserHelper.parse(data: layoutNodeConfigurationString)
    let mediaCertificateString = try container.decode(String.self, forKey: .mediaCertificate)
    mediaCertificate = ParserHelper.parse(data: mediaCertificateString)
    qualitySelectorConfiguration = try? container.decodeIfPresent([String: Any].self, forKey: .qualitySelectorConfiguration)
    let downloadQualityConfigurationString = try container.decode(String.self, forKey: .downloadQualityConfiguration)
    downloadQualityConfiguration = ParserHelper.parse(data: downloadQualityConfigurationString)
    let endplayerConfigString = try container.decode(String.self, forKey: .endplayerConfig)
    endplayerConfig = ParserHelper.parse(data: endplayerConfigString)
    let transactionalConfigurationTry = try container.decodeIfPresent(String.self, forKey: .transactionalConfiguration)
    if let transactionalConfigurationString = transactionalConfigurationTry {
      transactionalConfiguration = ParserHelper.parse(data: transactionalConfigurationString)
    }
    let livePPeAvailableStr = try container.decode(String.self, forKey: .livePPEAvailable)
    livePPEAvailable = ParserHelper.parse(data: livePPeAvailableStr)
    let loginProviderStr = try container.decode(String.self, forKey: .loginProviders)
    loginProviders = ParserHelper.parse(data: loginProviderStr)
    let socialLevelsString = try container.decode(String.self, forKey: .socialLevels)
    socialLevels = ParserHelper.parse(data: socialLevelsString)
    socializationEnabled = try container.decode(String.self, forKey: .socializationEnabled)
    socializationGameId = try container.decodeIfPresent(String.self, forKey: .socializationGameId)
    whatsNew = try container.decode(String.self, forKey: .whatsNew)
    let epgEventSafeTimeString = try container.decode(String.self, forKey: .epgEventSafeTime)
    epgEventSafeTime = ParserHelper.parse(data: epgEventSafeTimeString)
    let purchaseButtonConfigurationString = try container.decode(String.self, forKey: .purchaseButtonConfiguration)
    purchaseButtonConfiguration = ParserHelper.parse(data: purchaseButtonConfigurationString)
    let pushNotificationConfigString = try container.decode(String.self, forKey: .pushNotificationConfig)
    pushNotificationConfig = ParserHelper.parse(data: pushNotificationConfigString)
    let skipIntroConfigurationString = try container.decode(String.self, forKey: .skipIntroConfiguration)
    skipIntroConfiguration = ParserHelper.parse(data: skipIntroConfigurationString)
    let filterUnavailableChannelsString = try container.decode(String.self, forKey: .filterUnavailableChannels)
    filterUnavailableChannels = ParserHelper.parse(data: filterUnavailableChannelsString)
    let spritesConfigurationString = try container.decode(String.self, forKey: .spritesConfiguration)
    spritesConfiguration = ParserHelper.parse(data: spritesConfigurationString)
    let isFilterChannels = try? container.decode(Bool.self, forKey: .isFilterChannelsEnable)
    isFilterChannelsEnable = isFilterChannels ?? false
    let talentRolePriorityTry = try container.decodeIfPresent(String.self, forKey: .talentRolePriority)
    if let talentRolePriorityString = talentRolePriorityTry {
      talentRolePriority = ParserHelper.parse(data: talentRolePriorityString)
    }
    let loginRegisterOptionsTry = try container.decodeIfPresent(String.self, forKey: .loginRegisterOptions)
    if let loginRegisterOptionsString = loginRegisterOptionsTry {
      loginRegisterOptions = ParserHelper.parse(data: loginRegisterOptionsString)
    }
    let defaultGroupStr = try container.decode(String.self, forKey: .defaultGroupIdChannel)
    defaultGroupIdChannel = ParserHelper.parse(data: defaultGroupStr)
    let tenantCodeConfigurationString = try container.decode(String.self, forKey: .tenantCodeConfiguration)
    tenantCodeConfiguration = ParserHelper.parse(data: tenantCodeConfigurationString)
    let searchPriorityString = try container.decode(String.self, forKey: .searchPriority)
    searchPriority = ParserHelper.parse(data: searchPriorityString)
    let mobilePhoneProvidersConfigurationTry = try container.decodeIfPresent(String.self, forKey: .mobilePhoneProvidersConfiguration)
    if let mobilePhoneProvidersConfigurationString = mobilePhoneProvidersConfigurationTry {
      mobilePhoneProvidersConfiguration = ParserHelper.parse(data: mobilePhoneProvidersConfigurationString)
    }
    let ssoPlaceholderErrorsTry = try container.decodeIfPresent(String.self, forKey: .ssoPlaceholderErrors)
    if let ssoPlaceholderErrorsString = ssoPlaceholderErrorsTry {
      ssoPlaceholderErrors = ParserHelper.parse(data: ssoPlaceholderErrorsString)
    }
    let purchaseButtonColorsString = try container.decode(String.self, forKey: .purchaseButtonColors)
    purchaseButtonColors = ParserHelper.parse(data: purchaseButtonColorsString)
    let hiddenConfirmTransConfigString = try container.decode(String.self, forKey: .hiddenConfirmTransConfig)
    hiddenConfirmTransConfig = ParserHelper.parse(data: hiddenConfirmTransConfigString)
    let purchaseFlowConfigString = try container.decode(String.self, forKey: .purchaseFlowConfig)
    purchaseFlowConfig = ParserHelper.parse(data: purchaseFlowConfigString)
    let stickySessionString = try container.decode(String.self, forKey: .stickySession)
    stickySession = ParserHelper.parse(data: stickySessionString)
    let profilesConfigurationString = try container.decode(String.self, forKey: .profilesConfiguration)
    profilesConfiguration = ParserHelper.parse(data: profilesConfigurationString)
    let socialConfigurationString = try container.decode(String.self, forKey: .socialConfiguration)
    socialConfiguration = ParserHelper.parse(data: socialConfigurationString)
    let youboraConfigurationString = try container.decode(String.self, forKey: .youboraConfiguration)
    youboraConfiguration = ParserHelper.parse(data: youboraConfigurationString)
    if let epgChannelsEverywhereString = try? container.decode(String.self, forKey: .epgChannelsEverywhere) {
      epgChannelsEverywhere = ParserHelper.parse(data: epgChannelsEverywhereString)
    }
    if let rawValueStr = try? container.decode(String.self, forKey: .rawValue) {
      rawValue = ParserHelper.parse(data: rawValueStr)
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: metadataKeys.self)
    try codingKeys.encode(akamaiClientIp, forKey: .akamaiConfigUrl)
    try codingKeys.encode(akamaiConfigUrl, forKey: .akamaiClientIp)
    try codingKeys.encode(akamaiServerIp, forKey: .akamaiServerIp)
    try codingKeys.encode(baseUrlWebservices, forKey: .baseUrlWebservices)
    try codingKeys.encode(bufferInitial, forKey: .bufferInitial)
    try codingKeys.encode(bufferTotal, forKey: .bufferTotal)
    try codingKeys.encode(briefDwnldsMaxlimit, forKey: .briefDwnldsMaxlimit)
    try codingKeys.encode(cacheExpiration, forKey: .cacheExpiration)
    try codingKeys.encode(chromecast, forKey: .chromecast)
    try codingKeys.encode(chromecastId, forKey: .chromecastId)
    try codingKeys.encode(configUrl, forKey: .configUrl)
    try codingKeys.encode(customBaseUrl, forKey: .customBaseUrl)
    let deviceConfigurationStr = ParserHelper.encodeObject(data: deviceConfiguration)
    try codingKeys.encode(deviceConfigurationStr, forKey: .deviceConfiguration)
    try codingKeys.encode(devicesUrls, forKey: .devicesUrls)
    try codingKeys.encode(deviceTypeIdMapping, forKey: .deviceTypeIdMapping)
    try codingKeys.encode(deviceYearFwUpdateType, forKey: .deviceYearFwUpdateType)
    try codingKeys.encode(disclaimer, forKey: .disclaimer)
    try codingKeys.encode(enableForcePlayerStream, forKey: .enableForcePlayerStream)
    try codingKeys.encode(facebookAppkey, forKey: .facebookAppkey)
    try codingKeys.encode(facebookUrl, forKey: .facebookUrl)
    try codingKeys.encode(facebookUrlRegion, forKey: .facebookUrlRegion)
    try codingKeys.encode(fallbackAirplayHlsEnabled, forKey: .fallbackAirplayHlsEnabled)
    try codingKeys.encode(forceDownloadcenter, forKey: .forceDownloadcenter)
    try codingKeys.encode(forcePlayerStream, forKey: .forcePlayerStream)
    try codingKeys.encode(generalTimeout, forKey: .generalTimeout)
    try codingKeys.encode(googleAnalyticsId, forKey: .googleAnalyticsId)
    try codingKeys.encode(hdBadgesActive, forKey: .hdBadgesActive)
    try codingKeys.encode(headerInfoUrl, forKey: .headerInfoUrl)
    try codingKeys.encode(internetConnectionTimeout, forKey: .internetConnectionTimeout)
    try codingKeys.encode(internetConnectionUrl, forKey: .internetConnectionUrl)
    try codingKeys.encode(internetConnectionVerificationInterval, forKey: .internetConnectionVerificationInterval)
    try codingKeys.encode(isCss, forKey: .isCss)
    let navVisibilityStr = ParserHelper.encodeObject(data: self.navVisibility)
    try codingKeys.encode(navVisibilityStr, forKey: .navVisibility)
    try codingKeys.encode(isGoogleAnalyticsEnabled, forKey: .isGoogleAnalyticsEnabled)
    try codingKeys.encode(labelConfiguration, forKey: .labelConfiguration)
    try codingKeys.encode(landingCachetime, forKey: .landingCachetime)
    try codingKeys.encode(licenserTimeout, forKey: .licenserTimeout)
    try codingKeys.encode(maxApilevelMspr, forKey: .maxApilevelMspr)
    try codingKeys.encode(maxRetries, forKey: .maxRetries)
    try codingKeys.encode(maxVersionMspr, forKey: .maxVersionMspr)
    try codingKeys.encode(minApilevelMspr, forKey: .minApilevelMspr)
    try codingKeys.encode(minVersionMspr, forKey: .minVersionMspr)
    let monthStr = ParserHelper.encodeObject(data: self.months)
    try codingKeys.encode(monthStr, forKey: .months)
    try codingKeys.encode(nwEnableForcePlayerStream, forKey: .nwEnableForcePlayerStream)
    try codingKeys.encode(nwForcePlayerStream, forKey: .nwForcePlayerStream)
    try codingKeys.encode(nwRelicActivated, forKey: .nwRelicActivated)
    try codingKeys.encode(nwRelicAppKey, forKey: .nwRelicAppKey)
    try codingKeys.encode(forceAppKey, forKey: .forceAppKey)
    let openStoreLabelConfigurationStr = ParserHelper.encodeObject(data: openStoreLabelConfiguration)
    try codingKeys.encode(openStoreLabelConfigurationStr, forKey: .openStoreLabelConfiguration)
    try codingKeys.encode(parseAppid, forKey: .parseAppid)
    try codingKeys.encode(parseEnabled, forKey: .parseEnabled)
    try codingKeys.encode(parseKey, forKey: .parseKey)
    try codingKeys.encode(passwordMaxLength, forKey: .passwordMaxLength)
    try codingKeys.encode(passwordMinLength, forKey: .passwordMinLength)
    try codingKeys.encode(pinCodesLength, forKey: .pinCodesLength)
    try codingKeys.encode(playerGetMediaMaxRetries, forKey: .playerGetMediaMaxRetries)
    try codingKeys.encode(playerGetMediaTimeBetweenRetries, forKey: .playerGetMediaTimeBetweenRetries)
    try codingKeys.encode(playerMaxRetries, forKey: .playerMaxRetries)
    try codingKeys.encode(playerPausedSecondsoverlay, forKey: .playerPausedSecondsoverlay)
    try codingKeys.encode(playerTimeout, forKey: .playerTimeout)
    try codingKeys.encode(predictivesearchMinChars, forKey: .predictivesearchMinChars)
    try codingKeys.encode(prLicenseServer, forKey: .prLicenseServer)
    let providersLabelConfigurationStr = ParserHelper.encodeObject(data: providersLabelConfiguration)
    try codingKeys.encode(providersLabelConfigurationStr, forKey: .providersLabelConfiguration)
    let providersDetailPromoImgStr = ParserHelper.encodeObject(data: providersDetailPromoImg)
    try codingKeys.encode(providersDetailPromoImgStr, forKey: .providersDetailPromoImg)
    try codingKeys.encode(qualitychangeTimeout, forKey: .qualitychangeTimeout)
    let regionalConfigurationStr = ParserHelper.encodeObject(data: regionalConfiguration)
    try codingKeys.encode(regionalConfigurationStr, forKey: .regionalConfiguration)
    try codingKeys.encode(regionalParameters, forKey: .regionalParameters)
    try codingKeys.encode(ribbonEditCachetime, forKey: .ribbonEditCachetime)
    try codingKeys.encode(ribbonEditLoadnumber, forKey: .ribbonEditLoadnumber)
    try codingKeys.encode(ribbonPrecacheCount, forKey: .ribbonPrecacheCount)
    try codingKeys.encode(ribbonsMaxResults, forKey: .ribbonsMaxResults)
    try codingKeys.encode(ribbonsUser, forKey: .ribbonsUser)
    try codingKeys.encode(ribbonsUserStringcommas, forKey: .ribbonsUserStringcommas)
    try codingKeys.encode(ribbonUserCachetime, forKey: .ribbonUserCachetime)
    try codingKeys.encode(ribbonUserLoadnumber, forKey: .ribbonUserLoadnumber)
    try codingKeys.encode(skipSeconds, forKey: .skipSeconds)
    try codingKeys.encode(specialContentType1, forKey: .specialContentType1)
    try codingKeys.encode(specialContentType2, forKey: .specialContentType2)
    try codingKeys.encode(specialContentType3, forKey: .specialContentType3)
    try codingKeys.encode(specialContentType4, forKey: .specialContentType4)
    try codingKeys.encode(startBitrate, forKey: .startBitrate)
    try codingKeys.encode(startBitrateEnabled, forKey: .startBitrateEnabled)
    try codingKeys.encode(states, forKey: .states)
    try codingKeys.encode(streamTypeLive, forKey: .streamTypeLive)
    try codingKeys.encode(telcelServiceNotAvailableMessage, forKey: .telcelServiceNotAvailableMessage)
    try codingKeys.encode(timeLiveRequestPlayerDash, forKey: .timeLiveRequestPlayerDash)
    try codingKeys.encode(timeLiveRequestPlayerHls, forKey: .timeLiveRequestPlayerHls)
    try codingKeys.encode(timeLiveRequestPlayerHlsfrm, forKey: .timeLiveRequestPlayerHlsfrm)
    try codingKeys.encode(timeLiveRequestPlayerHlsprm, forKey: .timeLiveRequestPlayerHlsprm)
    try codingKeys.encode(timeLiveRequestPlayerSmooth, forKey: .timeLiveRequestPlayerSmooth)
    let externalMetadataStr = ParserHelper.encodeObject(data: externalMetadata)
    try codingKeys.encode(externalMetadataStr, forKey: .externalMetadata)
    let translationsStr = ParserHelper.encodeObject(data: translations)
    try codingKeys.encode(translationsStr, forKey: .translations)
    try codingKeys.encode(ttlChannelsUserLive, forKey: .ttlChannelsUserLive)
    try codingKeys.encode(userFavoritesQuantity, forKey: .userFavoritesQuantity)
    try codingKeys.encode(webservicesProtocol, forKey: .webservicesProtocol)
    try codingKeys.encode(detailPromoImage, forKey: .detailPromoImage)
    try codingKeys.encode(chromecastBehaviour, forKey: .chromecastBehaviour)
    let filterListStr = ParserHelper.encodeObject(data: filterList)
    try codingKeys.encode(filterListStr, forKey: .filterList)
    try codingKeys.encode(defaultNode, forKey: .defaultNode)
    let nodesConfigurationStr = ParserHelper.encodeObject(data: nodesConfiguration)
    try codingKeys.encode(nodesConfigurationStr, forKey: .nodesConfiguration)
    try codingKeys.encode(dashboardURL, forKey: .dashboardURL)
    try codingKeys.encode(defaultNode, forKey: .defaultNode)
    let layoutNodeConfigurationStr = ParserHelper.encodeObject(data: layoutNodeConfiguration)
    try codingKeys.encode(layoutNodeConfigurationStr, forKey: .layoutNodeConfiguration)
    let mediaCertificateStr = ParserHelper.encodeObject(data: mediaCertificate)
    try codingKeys.encode(mediaCertificateStr, forKey: .mediaCertificate)
    let qualitySelectorConfigurationStr = ParserHelper.encodeObject(data: qualitySelectorConfiguration)
    try codingKeys.encode(qualitySelectorConfigurationStr, forKey: .qualitySelectorConfiguration)
    let productPromoConfigurationStr = ParserHelper.encodeObject(data: productPromoConfiguration)
    try codingKeys.encode(productPromoConfigurationStr, forKey: .productPromoConfiguration)
    let downloadQualityConfigurationStr = ParserHelper.encodeObject(data: downloadQualityConfiguration)
    try codingKeys.encode(downloadQualityConfigurationStr, forKey: .downloadQualityConfiguration)
    let endplayerConfigStr = ParserHelper.encodeObject(data: endplayerConfig)
    try codingKeys.encode(endplayerConfigStr, forKey: .endplayerConfig)
    let transactionalConfigurationStr = ParserHelper.encodeObject(data: transactionalConfiguration)
    try codingKeys.encode(transactionalConfigurationStr, forKey: .transactionalConfiguration)
    let livePPEAvailableStr = ParserHelper.encodeObject(data: livePPEAvailable)
    try codingKeys.encode(livePPEAvailableStr, forKey: .livePPEAvailable)
    let loginProvidersStr = ParserHelper.encodeObject(data: loginProviders)
    try codingKeys.encode(loginProvidersStr, forKey: .loginProviders)
    let socialLevelsStr = ParserHelper.encodeObject(data: socialLevels)
    try codingKeys.encode(socialLevelsStr, forKey: .socialLevels)
    try codingKeys.encode(socializationEnabled, forKey: .socializationEnabled)
    try codingKeys.encode(socializationGameId, forKey: .socializationGameId)
    try codingKeys.encode(whatsNew, forKey: .whatsNew)
    let epgEventSafeTimeStr = ParserHelper.encodeObject(data: epgEventSafeTime)
    try codingKeys.encode(epgEventSafeTimeStr, forKey: .epgEventSafeTime)
    let purchaseButtonConfigurationStr = ParserHelper.encodeObject(data: purchaseButtonConfiguration)
    try codingKeys.encode(purchaseButtonConfigurationStr, forKey: .purchaseButtonConfiguration)
    let pushNotificationConfigStr = ParserHelper.encodeObject(data: pushNotificationConfig)
    try codingKeys.encode(pushNotificationConfigStr, forKey: .pushNotificationConfig)
    let skipIntroConfigurationStr = ParserHelper.encodeObject(data: skipIntroConfiguration)
    try codingKeys.encode(skipIntroConfigurationStr, forKey: .skipIntroConfiguration)
    let filterUnavailableChannelsStr = ParserHelper.encodeObject(data: filterUnavailableChannels)
    try codingKeys.encode(filterUnavailableChannelsStr, forKey: .filterUnavailableChannels)
    let spritesConfigurationStr = ParserHelper.encodeObject(data: spritesConfiguration)
    try codingKeys.encode(spritesConfigurationStr, forKey: .spritesConfiguration)
    try codingKeys.encode(isFilterChannelsEnable, forKey: .isFilterChannelsEnable)
    let talentRolePriorityStr = ParserHelper.encodeObject(data: talentRolePriority)
    try codingKeys.encode(talentRolePriorityStr, forKey: .talentRolePriority)
    let loginRegisterOptionsStr = ParserHelper.encodeObject(data: loginRegisterOptions)
    try codingKeys.encode(loginRegisterOptionsStr, forKey: .loginRegisterOptions)
    let defaultGroupIdChannelStr = ParserHelper.encodeObject(data: defaultGroupIdChannel)
    try codingKeys.encode(defaultGroupIdChannelStr, forKey: .defaultGroupIdChannel)
    let tenantCodeConfigurationStr = ParserHelper.encodeObject(data: tenantCodeConfiguration)
    try codingKeys.encode(tenantCodeConfigurationStr, forKey: .tenantCodeConfiguration)
    let searchPriorityStr = ParserHelper.encodeObject(data: searchPriority)
    try codingKeys.encode(searchPriorityStr, forKey: .searchPriority)
    let mobilePhoneProvidersConfigurationStr = ParserHelper.encodeObject(data: mobilePhoneProvidersConfiguration)
    try codingKeys.encode(mobilePhoneProvidersConfigurationStr, forKey: .mobilePhoneProvidersConfiguration)
    let ssoPlaceholderErrorsStr = ParserHelper.encodeObject(data: ssoPlaceholderErrors)
    try codingKeys.encode(ssoPlaceholderErrorsStr, forKey: .ssoPlaceholderErrors)
    let purchaseButtonColorsStr = ParserHelper.encodeObject(data: purchaseButtonColors)
    try codingKeys.encode(purchaseButtonColorsStr, forKey: .purchaseButtonColors)
    let hiddenConfirmTransConfigStr = ParserHelper.encodeObject(data: hiddenConfirmTransConfig)
    try codingKeys.encode(hiddenConfirmTransConfigStr, forKey: .hiddenConfirmTransConfig)
    let purchaseFlowConfigStr = ParserHelper.encodeObject(data: purchaseFlowConfig)
    try codingKeys.encode(purchaseFlowConfigStr, forKey: .purchaseFlowConfig)
    let stickySessionStr = ParserHelper.encodeObject(data: stickySession)
    try codingKeys.encode(stickySessionStr, forKey: .stickySession)
    let profilesConfigurationStr = ParserHelper.encodeObject(data: profilesConfiguration)
    try codingKeys.encode(profilesConfigurationStr, forKey: .profilesConfiguration)
    let socialConfigurationStr = ParserHelper.encodeObject(data: socialConfiguration)
    try codingKeys.encode(socialConfigurationStr, forKey: .socialConfiguration)
    let youboraConfigurationStr = ParserHelper.encodeObject(data: youboraConfiguration)
    try codingKeys.encode(youboraConfigurationStr, forKey: .youboraConfiguration)
    let epgChannelsEverywhereString = ParserHelper.encodeObject(data: epgChannelsEverywhere)
    try codingKeys.encode(epgChannelsEverywhereString, forKey: .epgChannelsEverywhere)
    let rawValueStr = ParserHelper.encodeObject(data: self.rawValue)
    try codingKeys.encode(rawValueStr, forKey: .rawValue)
  }
}
