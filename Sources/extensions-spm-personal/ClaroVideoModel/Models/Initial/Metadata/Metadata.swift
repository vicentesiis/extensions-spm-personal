//
//  Metadata.swift
//  ClaroVideoParser
//
//  Created by Adrian Salazar on 11/21/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

public final class Metadata: NSObject {
  
  public var rawValue: [String: Any]? = nil
  public var akamaiClientIp: String? = nil
  public var akamaiConfigUrl: String? = nil
  public var akamaiServerIp: String? = nil
  public var baseUrlWebservices: String? = nil
  public var bufferInitial: Int = 0
  public var bufferTotal: Int = 0
  public var briefDwnldsMaxlimit: String? = nil
  public var cacheExpiration: Int = 0
  public var chromecast: String? = nil
  public var chromecastId: String? = nil
  public var configUrl: String? = nil
  public var customBaseUrl: String? = nil
  public var deviceConfiguration: [String: Any]? = nil
  public var devicesUrls: String? = nil
  public var deviceTypeIdMapping: String? = nil
  public var deviceYearFwUpdateType: String? = nil
  public var disclaimer: String? = nil
  public var enableForcePlayerStream: String? = nil
  public var facebookAppkey: String? = nil
  public var facebookUrl: String? = nil
  public var facebookUrlRegion: String? = nil
  public var fallbackAirplayHlsEnabled: Bool = false
  public var forceDownloadcenter: Bool = false
  public var forcePlayerStream: String? = nil
  public var generalTimeout: Double = 0
  public var googleAnalyticsId: String? = nil
  public var hdBadgesActive: String? = nil
  public var headerInfoUrl: String? = nil
  public var internetConnectionTimeout: Int = 0
  public var internetConnectionUrl: String? = nil
  public var internetConnectionVerificationInterval: Int = 0
  public var isCss: String? = nil
  public var navVisibility: [[String: Any]]? = nil
  public var isGoogleAnalyticsEnabled: Bool = false
  public var labelConfiguration: String? = nil
  public var landingCachetime: Int = 0
  public var licenserTimeout: Int = 0
  public var maxApilevelMspr: Int = 0
  public var maxRetries: Int = 0
  public var maxVersionMspr: String? = nil
  public var minApilevelMspr: Int = 0
  public var minVersionMspr: String? = nil
  public var months: [String: Any]? = nil
  public var nwEnableForcePlayerStream: Bool = false
  public var nwForcePlayerStream: String? = nil
  public var nwRelicActivated: Bool = false
  public var nwRelicAppKey: String? = nil
  public var forceAppKey: String? = nil
  public var openStoreLabelConfiguration: [String: Any]? = nil
  public var parseAppid: String? = nil
  public var parseEnabled: String? = nil
  public var parseKey: String? = nil
  public var passwordMaxLength: Int = 0
  public var passwordMinLength: Int = 0
  public var pinCodesLength: Int = 0
  public var playerGetMediaMaxRetries: Int = 0
  public var playerGetMediaTimeBetweenRetries: Int = 0
  public var playerMaxRetries: Int = 0
  public var playerPausedSecondsoverlay: Int = 0
  public var playerTimeout: Int = 0
  public var predictivesearchMinChars: Int = 0
  public var prLicenseServer: String? = nil
  public var providersLabelConfiguration: [String: Any]? = nil
  public var providersDetailPromoImg: [String: Any]? = nil
  public var qualitychangeTimeout: Int = 0
  public var regionalConfiguration: [String: Any]? = nil
  public var regionalParameters: String? = nil
  public var ribbonEditCachetime: Int = 0
  public var ribbonEditLoadnumber: Int = 0
  public var ribbonPrecacheCount: Int = 0
  public var ribbonsMaxResults: Int = 0
  public var ribbonsUser: String? = nil
  public var ribbonsUserStringcommas: String? = nil
  public var ribbonUserCachetime: Int = 0
  public var ribbonUserLoadnumber: Int = 0
  public var skipSeconds: Int = 0
  public var specialContentType1: String? = nil
  public var specialContentType2: String? = nil
  public var specialContentType3: String? = nil
  public var specialContentType4: String? = nil
  public var startBitrate: Int = 0
  public var startBitrateEnabled: Bool = false
  public var states: String? = nil
  public var streamTypeLive: String? = nil
  public var telcelServiceNotAvailableMessage: String? = nil
  public var timeLiveRequestPlayerDash: Int = 0
  public var timeLiveRequestPlayerHls: String? = nil
  public var timeLiveRequestPlayerHlsfrm: String? = nil
  public var timeLiveRequestPlayerHlsprm: String? = nil
  public var timeLiveRequestPlayerSmooth: Int = 0
  public var externalMetadata: [String: Any]? = nil
  
  public var translations: [String: Any]? = nil
  
  public var ttlChannelsUserLive: Int = 0
  public var userFavoritesQuantity: Int = 0
  public var webservicesProtocol: String? = nil
  public var detailPromoImage: String? = nil
  public var chromecastBehaviour: String? = nil
  public var filterList: [String: Any]? = nil
  public var defaultNode: String? = nil
  public var nodesConfiguration: [String: Any]? = nil
  public var dashboardURL: String? = nil
  
public var layoutNodeConfiguration: [String: Any]? = nil
  public var mediaCertificate: [String: Any]? = nil
  public var qualitySelectorConfiguration: [String: Any]? = nil
  public var productPromoConfiguration: [String: Any]? = nil
public var downloadQualityConfiguration: [String: Any]? = nil
public var endplayerConfig: [String: Any]? = nil
public var transactionalConfiguration: [String: Any]? = nil
public var livePPEAvailable: [String: Any]? = nil
public var loginProviders: [String: Any]? = nil
  
  // Socialization
public var socialLevels: [String: Any]? = nil
public var socializationEnabled: String? = nil
public var socializationGameId: String? = nil
  // What's New
  public var whatsNew: String? = nil
  // Timeshift
  public var epgEventSafeTime: [String: Any]? = nil
  // Purchase button configuration
public var purchaseButtonConfiguration: [String: Any]? = nil
  // Push notification
  public var pushNotificationConfig: [String: Any]? = nil
  // Skip intro configuration
  public var skipIntroConfiguration: [String: Any]? = nil
  // Toggle Channel
public var filterUnavailableChannels: [String: Any]? = nil
  // Sprites
public var spritesConfiguration: [String: Any]? = nil
  // Custom getter
public var isFilterChannelsEnable: Bool = false
  // Talent role priority
public var talentRolePriority: [String: Any]? = nil
  // Login Register Options
public var loginRegisterOptions: [String: Any]? = nil
  // Default channel to playback player for the first time
public var defaultGroupIdChannel: [String: Any]? = nil
  // Tenant code configuration
  public var tenantCodeConfiguration: [String: Any]? = nil
  // Search Predictive Quantity configuration
public var searchPriority: [String: Any]? = nil
  // Mobile Phone Providers Configuration
public var mobilePhoneProvidersConfiguration: [String: Any]? = nil
  // sso Placeholder Errors
public var ssoPlaceholderErrors: [String: Any]? = nil
  // Purchase Button Colors
public var purchaseButtonColors: [String: Any]? = nil
  // Hidden Confirm TransConfig
  public var hiddenConfirmTransConfig: [String: Any]? = nil
  // Purchase Flow Config
  public var purchaseFlowConfig: [String: Any]? = nil
  // Sticky Session
public var stickySession: [String: Any]? = nil
  // Profiles Configuration
public var profilesConfiguration: [String: Any]? = nil
  // Social Configuration
public var socialConfiguration: [String: Any]? = nil
  // Youbora Configuration
public var youboraConfiguration: [String: Any]? = nil
  // epg channels everywhere flag for TVEverywhere
public var epgChannelsEverywhere: [String: Any]? = nil
}
