//
//  String+Localizable.swift
//  Clarovideo
//
//  Created by Miguel Angel Olmedo Perez on 17/01/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import UIKit

// MARK: - Localizable
extension String: Localizable {
  
  /// Localize string and delete all HTML references
  public var localized: String {
    return localizedUnescapped
  }
  
  public var isLocalized: Bool {
    return localizedUnescapped.trimmingCharacters(in: .whitespacesAndNewlines).isNotEmpty
  }
  
  public var localizedWithoutHtml: String {
    return localizedUnescapped.attributedLocalized.string
  }
  
  public var nonEmptyLocalized: String {
    guard self != self.localized else { return "" }
    return self.localized
  }
  
  /// Localizes string with a URL embeded
  public var attributedLocalized: NSAttributedString {
    guard let htmlData = data(using: .unicode),
          let attributedText = try? NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    else {
      return NSAttributedString(string: self as String)
    }
    return (attributedText)
  }
  
  /// Loads the String from LocalizableCache to improve performance when searching a key
  public var localizedUnescapped: String {
    get {
      /* If there are translations in the shared instance */
      if let localized = LocalizableCache.shared.translates[self] {
        /* Before the merge in develop we were converting to plain text each result */
        return localized
      }
      /* Create key and value for translations in the shared instance */
      let localized = self._localized
      LocalizableCache.shared.translates[self] = localized
      return localized
    }
  }
  
  /// Loads the String into the metadata's translations if not load the string from local translations
  private var _localized: String{
    get {
      // Ensure configuration is not nil if not search key on the local JSON file
      guard let metadata = LocalizableCache.shared.metadataTranslates else {
        return self
      }
      // Localizable key
      do {
        let translations = metadata.localized()
        return try self.localized(from: translations)
      } catch {
        return self
      }
    }
  }
  
  public func htmlAttributed(size: CGFloat, color: UIColor = .white, centering: Bool = false) -> NSMutableAttributedString? {
    let font = !IS_OSX() ? "Roboto" : "-apple-system"
    let htmlCSSString = "<style>" +
    "html *" +
    "{" +
    "font-size: \(size)pt !important;" +
    "color: #\(color.hexString) !important;" +
    "font-family: \(font) !important;" +
    "}</style> \(self)"
    
    let string = NSMutableAttributedString(attributedString: htmlCSSString.attributedLocalized)
    // Add Center aligment if needed
    guard centering else { return string }
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.center
    string.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, string.length))
    return string
  }
  
  
  public func getLocalized(completion: @escaping ClosureString) {
    if localizedUnescapped != self {
      completion(localizedUnescapped)
    } else {
      LocalizableCache.shared.listLocalizedWaiting[self] = completion
    }
  }
  
  // Localize string if string don`t have localized text return default
  public func localized(with defaultText: String) -> String {
    let localizedText = self.localizedWithoutHtml
    if localizedText == self {
      return defaultText
    }
    return localizedText
  }
  
  // MARK: - Helpers
  
  /// Validates if the dictionary contains the key(self).
  ///
  /// - Parameters:
  ///   - dictionary: The dicionary to validate
  ///   - configuration: The configuration of App that contains apa/metadata
  /// - Returns: A localizable string for key(self)
  /// - Throws: If the key not exits
  private func localized(from translations: [String: Any])  throws -> String {
    guard let localized = translations["\(self)"] as? String else {
      throw LocalizableError.keyNotFound("\(self)")
    }
    return localized
  }
}
