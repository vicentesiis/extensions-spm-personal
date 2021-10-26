//
//  Asset+Parceable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 12/5/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

extension Asset: Parceable {
  
  public static func parseObject(dictionary: [String : Any]) -> Result<Asset, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      
      let asset = try JSONDecoder().decode(Asset.self, from: jsonData)
      if asset.rawValue == nil {
         asset.rawValue = dictionary
      }
      return .success(asset)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}

extension Asset: Codable {
  
  enum assetKeys: String, CodingKey { // declaring our keys
    
    case claroIconRed = "claro_icon_red"
    case claroLogoHeaderXdk = "claro_logo_header_xdk"
    case claroLogoLoadingXdk = "claro_logo_loading_xdk"
    case claroLogoRedWhite = "claro_logo_red_white"
    case claroLogoRedWhiteMedium = "claro_logo_red_white_medium"
    case claroLogoSplashXdk = "claro_logo_splash_xdk"
    case headerTV = "header_tv"
    case horizontalArrowsTV = "horizontal_arrows_tv"
    case icMenuAll = "ic_menu_all"
    case icMenuChannels = "ic_menu_channels"
    case icMenuDefault = "ic_menu_default"
    case icMenuDeportes = "ic_menu_deportes"
    case icMenuDocumental = "ic_menu_documental"
    case icMenuHome = "ic_menu_home"
    case icMenuKids = "ic_menu_kids"
    case icMenuLatam = "ic_menu_latam"
    case icMenuMovies = "ic_menu_movies"
    case icMenuMusic = "ic_menu_music"
    case icMenuPpe = "ic_menu_ppe"
    case icMenuSeries = "ic_menu_series"
    case icMenuMiContenido = "ic_menu_micontenido"
    case icVerAhora = "ic_ver_ahora"
    case icAddProfile = "ic_add_profile"
    case icEditProfile = "listProfiles_access_option_icon_updateProfile"
    case loadingBarTV = "loading_bar_tv"
    case registerPricePanel = "register_price_panel"
    case registerPricePanelFull = "register_price_panel_full"
    case splashScreenTV = "splash_screen_tv"
    case updateSamsungBrazilian2012 = "update_samsung_brazilian_2012"
    case updateSamsungBrazilian2013 = "update_samsung_brazilian_2013"
    case updateSamsungSpanish2012 = "update_samsung_spanish_2012"
    case updateSamsungSpanish2013 = "update_samsung_spanish_2013"
    case verticalArrowsTV = "vertical_arrows_tv"
    case icDevices = "ic_devices"
    case icErrorData = "ic_error_data"
    case icHouston = "ic_houston"
    case icOk = "ic_ok"
    case icMatrix = "ic_matrix"
    case icAlert = "ic_alert"
    case icCancel = "ic_cancel"
    case icPhone = "ic_phone"
    case icWifi = "ic_wifi"
    case detailPromoPortraitSuscEs = "detail_promo_portrait_susc_es"
    case detailPromoPortraitSuscEsPor = "detail_promo_portrait_susc_es_por"
    case detailPromoPortraitSuscPt = "detail_promo_portrait_susc_pt"
    case detailPromoLandscapeSuscEs = "detail_promo_landscape_susc_es"
    case detailPromoLandscapeSuscEsPor = "detail_promo_landscape_susc_es_por"
    case detailPromoLandscapeSuscPt = "detail_promo_landscape_susc_pt"
    case detailPromoPortraitPpeEs = "detail_promo_portrait_ppe_es"
    case detailPromoPortraitPpeEsPor = "detail_promo_portrait_ppe_es_por"
    case detailPromoPortraitPpePt = "detail_promo_portrait_ppe_pt"
    case detailPromoLandscapePpeEs = "detail_promo_landscape_ppe_es"
    case detailPromoLandscapePpeEsPor = "detail_promo_landscape_ppe_es_por"
    case detailPromoLandscapePpePt = "detail_promo_landscape_ppe_pt"
    case detailPromoPortraitFreeEs = "detail_promo_portrait_free_es"
    case detailPromoPortraitFreeEsPor = "detail_promo_portrait_free_es_por"
    case detailPromoPortraitFreePt = "detail_promo_portrait_free_pt"
    case detailPromoLandscapeFreeEs = "detail_promo_landscape_free_es"
    case detailPromoLandscapeFreeEsPor = "detail_promo_landscape_free_es_por"
    case detailPromoLandscapeFreePt = "detail_promo_landscape_free_pt"
    
    
    case navFoxpremium = "nav_foxpremium"
    case navFoxpremiumOver = "nav_foxpremium_over"
    case navFoxpremiumPelicula = "nav_foxpremium_pelicula"
    case navFoxpremiumPeliculaOver = "nav_foxpremium_pelicula_over"
    case navFoxpremiumSerie = "nav_foxpremium_serie"
    case navFoxpremiumSerieOver = "nav_foxpremium_serie_over"
    
    case navFoxpremiumpeliculas = "nav_foxpremiumpeliculas"
    case navFoxpremiumpeliculasOver = "nav_foxpremiumpeliculas_over"
    case navFoxpremiumseries = "nav_foxpremiumseries"
    case navFoxpremiumseriesOver = "nav_foxpremiumseries_over"
    
    case navHbo = "nav_hbo"
    case navHboOver = "nav_hbo_over"
    case navHboadultos = "nav_hboadultos"
    case navHboadultosOver = "nav_hboadultos_over"
    case navHbodocumentales = "nav_hbodocumentales"
    case navHbodocumentalesOver = "nav_hbodocumentales_over"
    
    case navHboespeciales = "nav_hboespeciales"
    case navHboespecialesOver = "nav_hboespeciales_over"
    case navHboinfantil = "nav_hboinfantil"
    case navHboinfantilOver = "nav_hboinfantil_over"
    case navHbopeliculas = "nav_hbopeliculas"
    case navHbopeliculasOver = "nav_hbopeliculas_over"
    
    case navHboseries = "nav_hboseries"
    case navHboseriesOver = "nav_hboseries_over"
    case navPlayandgohbo = "nav_playandgohbo"
    case navPlayandgohboOver = "nav_playandgohbo_over"
    case navPlayandgomx = "nav_playandgomx"
    case navPlayandgomxOver = "nav_playandgomx_over"
    
    case icMenuParentalControl = "ic_menu_parental_control"
    
    case logoClaroHeader = "logo_claro_header"
    
    case rawValue
  }
  
  public convenience init(from decoder: Decoder) throws {
    self.init()
    
    let container = try decoder.container(keyedBy: assetKeys.self) // defining our (keyed) container
    claroIconRed = try container.decodeIfPresent(URL.self, forKey: .claroIconRed)
    claroLogoHeaderXdk = try container.decodeIfPresent(URL.self, forKey: .claroLogoHeaderXdk)
    claroLogoLoadingXdk = try container.decodeIfPresent(URL.self, forKey: .claroLogoLoadingXdk)
    claroLogoRedWhite = try container.decodeIfPresent(URL.self, forKey: .claroLogoRedWhite)
    claroLogoRedWhiteMedium = try container.decodeIfPresent(URL.self, forKey: .claroLogoRedWhiteMedium)
    claroLogoSplashXdk = try container.decodeIfPresent(URL.self, forKey: .claroLogoSplashXdk)
    headerTV = try container.decodeIfPresent(URL.self, forKey: .headerTV)
    horizontalArrowsTV = try container.decodeIfPresent(URL.self, forKey: .horizontalArrowsTV)
    icMenuAll = try container.decodeIfPresent(URL.self, forKey: .icMenuAll)
    icMenuChannels = try container.decodeIfPresent(URL.self, forKey: .icMenuChannels)
    icMenuDefault = try container.decodeIfPresent(URL.self, forKey: .icMenuDefault)
    icMenuDeportes = try container.decodeIfPresent(URL.self, forKey: .icMenuDeportes)
    icMenuDocumental = try container.decodeIfPresent(URL.self, forKey: .icMenuDocumental)
    icMenuHome = try container.decodeIfPresent(URL.self, forKey: .icMenuHome)
    icMenuKids = try container.decodeIfPresent(URL.self, forKey: .icMenuKids)
    icMenuLatam = try container.decodeIfPresent(URL.self, forKey: .icMenuLatam)
    icMenuMovies = try container.decodeIfPresent(URL.self, forKey: .icMenuMovies)
    icMenuMusic = try container.decodeIfPresent(URL.self, forKey: .icMenuMusic)
    icMenuPpe = try container.decodeIfPresent(URL.self, forKey: .icMenuPpe)
    icMenuSeries = try container.decodeIfPresent(URL.self, forKey: .icMenuSeries)
    icMenuMiContenido = try container.decodeIfPresent(URL.self, forKey: .icMenuMiContenido)
    icVerAhora = try container.decodeIfPresent(URL.self, forKey: .icVerAhora)
    icAddProfile = try container.decodeIfPresent(URL.self, forKey: .icAddProfile)
    icEditProfile = try container.decodeIfPresent(URL.self, forKey: .icEditProfile)
    loadingBarTV = try container.decodeIfPresent(URL.self, forKey: .loadingBarTV)
    registerPricePanel = try container.decodeIfPresent(URL.self, forKey: .registerPricePanel)
    registerPricePanelFull = try container.decodeIfPresent(URL.self, forKey: .registerPricePanelFull)
    splashScreenTV = try container.decodeIfPresent(URL.self, forKey: .splashScreenTV)
    updateSamsungBrazilian2012 = try container.decodeIfPresent(URL.self, forKey: .updateSamsungBrazilian2012)
    updateSamsungBrazilian2013 = try container.decodeIfPresent(URL.self, forKey: .updateSamsungBrazilian2013)
    updateSamsungSpanish2012 = try container.decodeIfPresent(URL.self, forKey: .updateSamsungSpanish2012)
    updateSamsungSpanish2013 = try container.decodeIfPresent(URL.self, forKey: .updateSamsungSpanish2013)
    verticalArrowsTV = try container.decodeIfPresent(URL.self, forKey: .verticalArrowsTV)
    icDevices = try container.decodeIfPresent(URL.self, forKey: .icDevices)
    icErrorData = try container.decodeIfPresent(URL.self, forKey: .icErrorData)
    icHouston = try container.decodeIfPresent(URL.self, forKey: .icHouston)
    icOk = try container.decodeIfPresent(URL.self, forKey: .icOk)
    icMatrix = try container.decodeIfPresent(URL.self, forKey: .icMatrix)
    icAlert = try container.decodeIfPresent(URL.self, forKey: .icAlert)
    icCancel = try container.decodeIfPresent(URL.self, forKey: .icCancel)
    icPhone = try container.decodeIfPresent(URL.self, forKey: .icPhone)
    icWifi = try container.decodeIfPresent(URL.self, forKey: .icWifi)
    detailPromoPortraitSuscEs = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitSuscEs)
    detailPromoPortraitSuscEsPor = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitSuscEsPor)
    detailPromoPortraitSuscPt = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitSuscPt)
    detailPromoLandscapeSuscEs = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapeSuscEs)
    detailPromoLandscapeSuscEsPor = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapeSuscEsPor)
    detailPromoLandscapeSuscPt = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapeSuscPt)
    detailPromoPortraitPpeEs = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitPpeEs)
    detailPromoPortraitPpeEsPor = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitPpeEsPor)
    detailPromoPortraitPpePt = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitPpePt)
    detailPromoLandscapePpeEs = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapePpeEs)
    detailPromoLandscapePpeEsPor = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapePpeEsPor)
    detailPromoLandscapePpePt = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapePpePt)
    detailPromoPortraitFreeEs = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitFreeEs)
    detailPromoPortraitFreeEsPor = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitFreeEsPor)
    detailPromoPortraitFreePt = try container.decodeIfPresent(URL.self, forKey: .detailPromoPortraitFreePt)
    detailPromoLandscapeFreeEs = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapeFreeEs)
    detailPromoLandscapeFreeEsPor = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapeFreeEsPor)
    detailPromoLandscapeFreePt = try container.decodeIfPresent(URL.self, forKey: .detailPromoLandscapeFreePt)
    
    navFoxpremium = try container.decodeIfPresent(URL.self, forKey: .navFoxpremium)
    navFoxpremiumOver = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumOver)
    navFoxpremiumPelicula = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumPelicula)
    navFoxpremiumPeliculaOver = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumPeliculaOver)
    navFoxpremiumSerie = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumSerie)
    navFoxpremiumSerieOver = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumSerieOver)
    
    navFoxpremiumpeliculas = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumpeliculas)
    navFoxpremiumpeliculasOver = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumpeliculasOver)
    navFoxpremiumseries = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumseries)
    navFoxpremiumseriesOver = try container.decodeIfPresent(URL.self, forKey: .navFoxpremiumseriesOver)
    
    navHbo = try container.decodeIfPresent(URL.self, forKey: .navHbo)
    navHboOver = try container.decodeIfPresent(URL.self, forKey: .navHboOver)
    navHboadultos = try container.decodeIfPresent(URL.self, forKey: .navHboadultos)
    navHboadultosOver = try container.decodeIfPresent(URL.self, forKey: .navHboadultosOver)
    navHbodocumentales = try container.decodeIfPresent(URL.self, forKey: .navHbodocumentales)
    navHbodocumentalesOver = try container.decodeIfPresent(URL.self, forKey: .navHbodocumentalesOver)
    
    navHboespeciales = try container.decodeIfPresent(URL.self, forKey: .navHboespeciales)
    navHboespecialesOver = try container.decodeIfPresent(URL.self, forKey: .navHboespecialesOver)
    navHboinfantil = try container.decodeIfPresent(URL.self, forKey: .navHboinfantil)
    navHboinfantilOver = try container.decodeIfPresent(URL.self, forKey: .navHboinfantilOver)
    navHbopeliculas = try container.decodeIfPresent(URL.self, forKey: .navHbopeliculas)
    navHbopeliculasOver = try container.decodeIfPresent(URL.self, forKey: .navHbopeliculasOver)
    
    navHboseries = try container.decodeIfPresent(URL.self, forKey: .navHboseries)
    navHboseriesOver = try container.decodeIfPresent(URL.self, forKey: .navHboseriesOver)
    navPlayandgohbo = try container.decodeIfPresent(URL.self, forKey: .navPlayandgohbo)
    navPlayandgohboOver = try container.decodeIfPresent(URL.self, forKey: .navPlayandgohboOver)
    navPlayandgomx = try container.decodeIfPresent(URL.self, forKey: .navPlayandgomx)
    navPlayandgomxOver = try container.decodeIfPresent(URL.self, forKey: .navPlayandgomxOver)
    
    icMenuParentalControl = try container.decodeIfPresent(URL.self, forKey: .icMenuParentalControl)
    
    logoClaroHeader = try container.decodeIfPresent(URL.self, forKey: .logoClaroHeader)
    
    if let rawValueStr = try? container.decode(String.self, forKey: .rawValue) {
      rawValue = ParserHelper.parse(data: rawValueStr)
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: assetKeys.self)
    try codingKeys.encode(claroIconRed, forKey: .claroIconRed)
    try codingKeys.encode(claroLogoHeaderXdk, forKey: .claroLogoHeaderXdk)
    try codingKeys.encode(claroLogoLoadingXdk, forKey: .claroLogoLoadingXdk)
    try codingKeys.encode(claroLogoRedWhite, forKey: .claroLogoRedWhite)
    try codingKeys.encode(claroLogoRedWhiteMedium, forKey: .claroLogoRedWhiteMedium)
    try codingKeys.encode(claroLogoSplashXdk, forKey: .claroLogoSplashXdk)
    try codingKeys.encode(headerTV, forKey: .headerTV)
    try codingKeys.encode(horizontalArrowsTV, forKey: .horizontalArrowsTV)
    try codingKeys.encode(icMenuAll, forKey: .icMenuAll)
    try codingKeys.encode(icMenuChannels, forKey: .icMenuChannels)
    try codingKeys.encode(icMenuDefault, forKey: .icMenuDefault)
    try codingKeys.encode(icMenuDeportes, forKey: .icMenuDeportes)
    try codingKeys.encode(icMenuDocumental, forKey: .icMenuDocumental)
    try codingKeys.encode(icMenuHome, forKey: .icMenuHome)
    try codingKeys.encode(icMenuKids, forKey: .icMenuKids)
    try codingKeys.encode(icMenuLatam, forKey: .icMenuLatam)
    try codingKeys.encode(icMenuMovies, forKey: .icMenuMovies)
    try codingKeys.encode(icMenuMusic, forKey: .icMenuMusic)
    try codingKeys.encode(icMenuPpe, forKey: .icMenuPpe)
    try codingKeys.encode(icMenuSeries, forKey: .icMenuSeries)
    try codingKeys.encode(icMenuMiContenido, forKey: .icMenuMiContenido)
    try codingKeys.encode(icVerAhora, forKey: .icVerAhora)
    try codingKeys.encode(icAddProfile, forKey: .icAddProfile)
    try codingKeys.encode(icEditProfile, forKey: .icEditProfile)
    try codingKeys.encode(loadingBarTV, forKey: .icEditProfile)
    try codingKeys.encode(registerPricePanel, forKey: .registerPricePanel)
    try codingKeys.encode(registerPricePanelFull, forKey: .registerPricePanelFull)
    try codingKeys.encode(splashScreenTV, forKey: .splashScreenTV)
    try codingKeys.encode(updateSamsungBrazilian2012, forKey: .updateSamsungBrazilian2012)
    try codingKeys.encode(updateSamsungBrazilian2013, forKey: .updateSamsungBrazilian2013)
    try codingKeys.encode(updateSamsungSpanish2012, forKey: .updateSamsungSpanish2012)
    try codingKeys.encode(updateSamsungSpanish2013, forKey: .updateSamsungSpanish2013)
    try codingKeys.encode(verticalArrowsTV, forKey: .verticalArrowsTV)
    try codingKeys.encode(icDevices, forKey: .icDevices)
    try codingKeys.encode(icErrorData, forKey: .icErrorData)
    try codingKeys.encode(icHouston, forKey: .icHouston)
    try codingKeys.encode(icOk, forKey: .icOk)
    try codingKeys.encode(icMatrix, forKey: .icMatrix)
    try codingKeys.encode(icAlert, forKey: .icAlert)
    try codingKeys.encode(icCancel, forKey: .icCancel)
    try codingKeys.encode(icPhone, forKey: .icPhone)
    try codingKeys.encode(icWifi, forKey: .icWifi)
    try codingKeys.encode(detailPromoPortraitSuscEs, forKey: .detailPromoPortraitSuscEs)
    try codingKeys.encode(detailPromoPortraitSuscEsPor, forKey: .detailPromoPortraitSuscEsPor)
    try codingKeys.encode(detailPromoPortraitSuscPt, forKey: .detailPromoPortraitSuscPt)
    try codingKeys.encode(detailPromoLandscapeSuscEs, forKey: .detailPromoLandscapeSuscEs)
    try codingKeys.encode(detailPromoLandscapeSuscEsPor, forKey: .detailPromoLandscapeSuscEsPor)
    try codingKeys.encode(detailPromoLandscapeSuscPt, forKey: .detailPromoLandscapeSuscPt)
    try codingKeys.encode(detailPromoPortraitPpeEs, forKey: .detailPromoPortraitPpeEs)
    try codingKeys.encode(detailPromoPortraitPpeEsPor, forKey: .detailPromoPortraitPpeEsPor)
    try codingKeys.encode(detailPromoPortraitPpePt, forKey: .detailPromoPortraitPpePt)
    try codingKeys.encode(detailPromoLandscapePpeEs, forKey: .detailPromoLandscapePpeEs)
    try codingKeys.encode(detailPromoLandscapePpeEsPor, forKey: .detailPromoLandscapePpeEsPor)
    try codingKeys.encode(detailPromoLandscapePpePt, forKey: .detailPromoLandscapePpePt)
    try codingKeys.encode(detailPromoPortraitFreeEs, forKey: .detailPromoPortraitFreeEs)
    try codingKeys.encode(detailPromoPortraitFreeEsPor, forKey: .detailPromoPortraitFreeEsPor)
    try codingKeys.encode(detailPromoPortraitFreePt, forKey: .detailPromoPortraitFreePt)
    try codingKeys.encode(detailPromoLandscapeFreeEs, forKey: .detailPromoLandscapeFreeEs)
    try codingKeys.encode(detailPromoLandscapeFreeEsPor, forKey: .detailPromoLandscapeFreeEsPor)
    try codingKeys.encode(detailPromoLandscapeFreePt, forKey: .detailPromoLandscapeFreePt)
    
    
    try codingKeys.encode(navFoxpremium, forKey: .navFoxpremium)
    try codingKeys.encode(navFoxpremiumOver, forKey: .navFoxpremiumOver)
    try codingKeys.encode(navFoxpremiumPelicula, forKey: .navFoxpremiumPelicula)
    try codingKeys.encode(navFoxpremiumPeliculaOver, forKey: .navFoxpremiumPeliculaOver)
    try codingKeys.encode(navFoxpremiumSerie, forKey: .navFoxpremiumSerie)
    try codingKeys.encode(navFoxpremiumSerieOver, forKey: .navFoxpremiumSerieOver)
    
    try codingKeys.encode(navFoxpremiumpeliculas, forKey: .navFoxpremiumpeliculas)
    try codingKeys.encode(navFoxpremiumpeliculasOver, forKey: .navFoxpremiumpeliculasOver)
    try codingKeys.encode(navFoxpremiumseries, forKey: .navFoxpremiumseries)
    try codingKeys.encode(navFoxpremiumseriesOver, forKey: .navFoxpremiumseriesOver)
    
    try codingKeys.encode(navHbo, forKey: .navHbo)
    try codingKeys.encode(navHboOver, forKey: .navHboOver)
    try codingKeys.encode(navHboadultos, forKey: .navHboadultos)
    try codingKeys.encode(navHboadultosOver, forKey: .navHboadultosOver)
    try codingKeys.encode(navHbodocumentales, forKey: .navHbodocumentales)
    try codingKeys.encode(navHbodocumentalesOver, forKey: .navHbodocumentalesOver)
    
    try codingKeys.encode(navHboespeciales, forKey: .navHboespeciales)
    try codingKeys.encode(navHboespecialesOver, forKey: .navHboespecialesOver)
    try codingKeys.encode(navHboinfantil, forKey: .navHboinfantil)
    try codingKeys.encode(navHboinfantilOver, forKey: .navHboinfantilOver)
    try codingKeys.encode(navHbopeliculas, forKey: .navHbopeliculas)
    try codingKeys.encode(navHbopeliculasOver, forKey: .navHbopeliculasOver)
    
    try codingKeys.encode(navHboseries, forKey: .navHboseries)
    try codingKeys.encode(navHboseriesOver, forKey: .navHboseriesOver)
    try codingKeys.encode(navPlayandgohbo, forKey: .navPlayandgohbo)
    try codingKeys.encode(navPlayandgohboOver, forKey: .navPlayandgohboOver)
    try codingKeys.encode(navPlayandgomx, forKey: .navPlayandgomx)
    try codingKeys.encode(navPlayandgomxOver, forKey: .navPlayandgomxOver)
    
    try codingKeys.encode(icMenuParentalControl, forKey: .icMenuParentalControl)
    
    try codingKeys.encode(logoClaroHeader, forKey: .logoClaroHeader)
    
    let rawValueStr = ParserHelper.encodeObject(data: self.rawValue)
    try codingKeys.encode(rawValueStr, forKey: .rawValue)
  }
}

