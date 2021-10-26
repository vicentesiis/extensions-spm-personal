//
//  CVContants.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 31/05/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

//MARK: CVConstants
/// Constants for Api values
public struct CVApiData {
  public static let jsonFormat         = "json"
  public static let apiVersion         = "v5.93"
  public static let authpnValue        = "amco"
  public static let authptValue        = "12e4i8l6a581a"
  public static let authApiVersionKey  = "api_version"
  public static let regionNET          = "brasil"
  public static let urlToStore         = "itms-apps://itunes.apple.com/app/apple-store/id568894377"
  public static let reverseDomain      = "com.dla.Clarovideo"
  public static let translationKey     = "d48c48c956cda082e2e03b717c81c220"
  public static let nav                = "nav"
  public static let whatIncludesType   = "abonos"
}

/// Constants for Providers
public struct CVProviderCode {
  public static let amco             = "amco"
  public static let amcoMusic        = "AMCO"
  public static let fox              = "fox"
  public static let foxv3            = "foxv3"
  public static let hbo              = "hbo"
  public static let picardia         = "picardia"
  public static let stingraykaraoke  = "stingraykaraoke"
  public static let stingrayqello    = "stingrayqello"
  public static let atresplayer      = "ATRESplayer"
}

/// Constants for StreamTypes
public struct CVStreamType {
  public static let hls              = "hls"
  public static let hlsma            = "hls_ma"
  public static let hlsFairplay      = "hlsfps"
  public static let hlsFairplayMA    = "hlsfps_ma"
  public static let hlsKR            = "hls_kr"
  public static let smoothStreaming  = "smooth_streaming"
  public static let musicHLSFP       = "hls"
}

/// ContentType
public struct CVContentType {
  public static let ppe              = "ppe"
  public static let est              = "est"
  public static let free             = "free"
  public static let rent             = "rent"
  public static let download         = "download"
  public static let liveEvent        = "live_event"
  public static let vod              =  "vod"
  public static let liveTypeAvailable    =  "live_play1"
  public static let liveTypeNotAvailable =  "live_play0"
}

// Search Priority
public struct CVSearchPriority {
  public static let suggest                 = "suggest"
  public static let movies                  = "movies"
  public static let series                  = "series"
  public static let epgsFuture              = "epgs_future"
  public static let epgsNow                 = "epgs_now"
  public static let epgsPast                = "epgs_past"
  public static let genres                  = "genres"
  public static let talents                 = "talents"
  public static let users                   = "users"
}

/// ReplaceKeys
public struct CVReplaceKeys {
  public static let family           = "<family>"
  public static let productType      = "<product_type>"
  public static let bonus            = "<bonus_PBI>"
  public static let region           = "<region>"
  public static let category         = "<category>"
  public static let rating           = "<rating_id>"
  public static let productCode      = "<product_code>"
  public static let hourBegin        = "<hourBegin>"
  public static let hourEnd          = "<hourEnd>"
  public static let title            = "<title>"
  public static let email            = "{@EMAIL}"
  public static let productDuration  = "{{productduration}}"
  public static let episodeNumber    = "{@episode_number}"
  public static let seassonNumber    = "{@season_number}"
  public static let month            = "{@month}"
  public static let day              = "{@day}"
  public static let year             = "{@YYYY}"
  public static let hour             = "{@hrs}"
  public static let minute           = "{@min}"
  public static let fallenChannel    = "@CHANNEL"
  public static let channel          = "@canal"
  public static let extMediaProvCod  = "<providerCode>"
  public static let extMediaFormType = "<formatType>"
}

/// CVTimeConstants
public enum CVTimeConstants {
  public static let defaultControlsAutoHide: Double = 12,
             defaultMiniEpgAutoHide: Double = 5,
             defaultAutoHideSkipIntro: Double = 7,
             defaultRemindersInterval = 10, // number in min
             defaultUtoHideAlertLive: Double = 3,
             defaultAutoHideKidsTooltip: Double = 14
}

//MARK: iTunes AND PAYMENT
public struct CViTunesConstants {
  public static let receiptValidatorSandbox = "https://sandbox.itunes.apple.com/verifyReceipt"
  public static let secret = "8d55d370777b4acc99a084850b31b07f"
  public static let transactionTypeMonthly = "monthly_subscription"
  public static let transactionTypeWeekly = "weekly_subscription"
  public static let transactionTypeRent = "rent"
  public static let transactionTypePurchase = "purchase"
}

/// Gateway
public struct CVGateway {
  public static let plazavipgate        = "plazavipgate"       // TDC
  public static let telmexmexicogate    = "telmexmexicogate"   // Recibo telmex
  public static let hubgate             = "hubgate"            // Móvil (en México es telcel)
  public static let promogate           = "promogate"          // PIN codes
  public static let iTunesgate          = "itunesgate"         // iTunes
}

/// Constants for Subscription Payments on the TenantCode
public struct CVPaymentType {
  public static let payTV                        = "ptv"
  public static let paymentMethods               = "paymentMethods"
  public static let hubcorporativofijogate       = "hubcorporativofijogate"
  public static let hubfijovirtualgate           = "hubfijovirtualgate"
  public static let forceAppkey                  = "force_appkey"
  public static let tenantCode                   = "clarovideo"
  public static let tenantCodeTV                 = "clarotv"
  public static let epg                          = "epg"
}

/// One offer type
public struct CVOneOfferType {
  public static let subscription = "subscrition"
  public static let rentPremiere = "download_rent"
  public static let rentStandard = "rent"
  public static let buy = "download_buy"
  public static let offerId = "offerid"
  public static let buyEpisode = "CV_EPISODEBUY"
  public static let buySeason = "CV_SEASONBUY"
  public static let buyMonthly = "CV_MENSUAL_wp0"
  public static let buyYearly = "CV_ANUAL_wp0"
}

public enum CVSearchPredictiveType: Int {
  case full
  case predictive
}


