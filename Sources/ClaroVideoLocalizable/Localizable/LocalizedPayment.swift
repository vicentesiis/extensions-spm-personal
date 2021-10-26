//
//  LocalizedPayment.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 20/10/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public struct LocalizedPayment {
  public static func getTrialText(bonusLocalized: Bool = true, keyPrefix: String, bonus: String,
                                  complementKey: String? = nil)->String {
    guard bonusLocalized else { return "" }
    
    let suscriptionTrialPrefixKey = keyPrefix.replacingOccurrences(of: CVReplaceKeys.bonus, with: bonus)
    let suscriptionIsEmpty = suscriptionTrialPrefixKey.localized.isEmpty || suscriptionTrialPrefixKey.localized == suscriptionTrialPrefixKey
    let suscriptionTrialPrefix = suscriptionIsEmpty ? "" : "\(suscriptionTrialPrefixKey.localized) "
    let suscriptionTrialPeriod = bonus.localized != bonus ? bonus.localized : ""
    
    var complementText = ""
    if let complementKey = complementKey {
      let complement = complementKey.replacingOccurrences(of: CVReplaceKeys.bonus, with: bonus)
      complementText = complement.localized.isNotEmpty && complement.localized != complement ? complement.localized : ""
    }
    
    return "\(suscriptionTrialPrefix)\(suscriptionTrialPeriod)\(complementText)"
  }
  
  public static func getAttributedTextTrial(textComplete: String, textWhite: String, fontSize: CGFloat)->NSAttributedString {
    let font = CVFont.bold.of(size: fontSize)
    let attributes: [NSAttributedString.Key: Any] = [
      .font: font,
      .foregroundColor: UIColor.cvBlue._00AAFF,
    ]
    let attributedTitle = NSMutableAttributedString(string: "\(textComplete)")
    let range = textComplete.count > textWhite.count ? (textComplete.count - textWhite.count) : textComplete.count
    attributedTitle.addAttributes(attributes, range: NSMakeRange(0, range))
    return attributedTitle
  }
  
  public static func getSubscribeText(bonus: String, producttype: String)->String {
    var titleButton = ""
    let bonus = lsBonusButton.replacingOccurrences(of: CVReplaceKeys.bonus, with: bonus)
    if bonus.isLocalized, !bonus.localized.isEmpty, bonus.localized != bonus  {
      let test = lsTryLabel.replacingOccurrences(of: CVReplaceKeys.productType, with: producttype).localized
      titleButton = test + " " + bonus.localized
    } else {
      titleButton = lsNoBonusButton.localized
    }
    return titleButton
  }
  
  public static func getPrice(purchaseButton: PurchaseButton, fontSize: CGFloat, addPeriodicity: Bool = true, isTaxLineFeed: Bool = false)->NSAttributedString {
    let currency = purchaseButton.currency
    let price = purchaseButton.price
    
    let taxes = lsTaxIncludedLabel.replacingOccurrences(of: CVReplaceKeys.productType, with: purchaseButton.producttype)
    
    let slash = lsSlashPrice.localized
    let perodiocity = purchaseButton.periodicity
    
    let existTaxes = taxes != taxes.localized && taxes.localized.isNotEmpty
    let existPerodiocity = perodiocity != perodiocity.localized && perodiocity.localized.isNotEmpty
    
    let taxesText = existTaxes ? " \(taxes.localized)" : ""
    let perodiocityText = existPerodiocity && addPeriodicity ? " \(slash)\(perodiocity.localized)" : ""
    
    let priceText = "\(currency)\(price)"
    let complement = "\(taxesText)\(perodiocityText)"
    
    let fontBold = CVFont.bold.of(size: fontSize)
    let fontRegular = CVFont.regular.of(size: fontSize / 1.7)
    
    let attributesPrice: [NSAttributedString.Key: Any] = [.font: fontBold]
    let attributesOther: [NSAttributedString.Key: Any] = [.font: fontRegular]
    let textComplete = "\(priceText)\(isTaxLineFeed ? "\n" : " ")\(complement)"
    let attributedTitle = NSMutableAttributedString(string: textComplete)
    attributedTitle.addAttributes(attributesPrice, range: NSMakeRange(0, priceText.count))
    if priceText.count + 1 < complement.count {
      attributedTitle.addAttributes(attributesOther, range: NSMakeRange(priceText.count + 1, complement.count))
    }
    return attributedTitle
  }
}
