//
//  String+Utils.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 16/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

// MARK: -  String+Utils
public extension String {
  
  //MARK: - Properties
  var boolValue: Bool {
    let boolStr = self.lowercased()
    return (boolStr == "true" || boolStr == "1" || boolStr == "yes")
  }
  
  var isValidEmail: Bool {
    guard !self.isEmpty else { return false }
    let emailTest = NSPredicate(format: "SELF MATCHES %@", StringConstants.emailPattern)
    return emailTest.evaluate(with: self)
  }
  
  var isValidPhone: Bool {
    guard !self.isEmpty else { return false }
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", StringConstants.emailPattern)
    return phoneTest.evaluate(with: self)
  }
  
  var hasSpecialCharacters: Bool {
    guard !self.isEmpty else { return false }
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", StringConstants.noSpecialCharacterPatthern)
    return (phoneTest.evaluate(with: self))
  }
  
  var getNumbers: String? {
    let pattern = UnicodeScalar("0")..."9"
    return String(unicodeScalars.compactMap { pattern ~= $0 ? Character($0) : nil })
  }
  
  var firebaseParam: String {
    return self.lowercased().replacingOccurrences(of: " ", with: "_")
  }
  
  var containsOnlyNumbers: Bool {
    return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
  }
  
  /// Property to get string from HTML text.
  /// If the text is not HTML  returns an empty string.
  var htmlText: String {
    guard let data = data(using: .utf8) else { return "" }
    // Option for HTML String
    var options: [NSAttributedString.DocumentReadingOptionKey : Any] = [:]
    options[.documentType] = NSAttributedString.DocumentType.html
    options[.characterEncoding] = String.Encoding.utf8.rawValue
    let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    return attributed?.string ?? self
  }
  
  // MARK: -  Text size
  func textWidth(height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.width)
  }
  
  func textHeight(width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height:.greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.height)
  }
  
  func width(withAttributes attributes: [NSAttributedString.Key : Any]) -> CGFloat {
    return (self as NSString).size(withAttributes: attributes).width
  }
  
  func size(font: UIFont, width: CGFloat) -> CGSize {
    let attrString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
    let bounds = attrString.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
    let size = CGSize(width: bounds.width, height: bounds.height)
    return size
  }
  
  // MARK: -  String+Hashes
  
  /// Get the Sha1 String
  ///
  /// [How to crypt string to sha1 with Swift]:
  /// https://stackoverflow.com/questions/25761344/how-to-crypt-string-to-sha1-with-swift "reference"
  ///
  /// For more information, see [How to crypt string to sha1 with Swift]
  ///
  /// - Returns: Result string for sha1
  func sha1() -> String {
    let data = Data(self.utf8)
    var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
    data.withUnsafeBytes {
      _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
    }
    let hexBytes = digest.map { String(format: "%02hhx", $0) }
    return hexBytes.joined()
  }
  
  //MARK: - PathComponent
  func appendPathComponent(_ pathComponent: String) -> String {
    guard let last = self.last, last == "/" else {
      return self + "/" + pathComponent
    }
    return self + pathComponent
  }
  
  //MARK: - String+Regex
  func getRegexpMatch(patthern: String, andIndex index: Int) -> String {
    if index < 0 {
      return ""
    }
    let expression = getRegularExpression(with: patthern)
    if let match = expression.0 {
      return String(self.substring(with: match.range(at: index)) ?? "")
    }
    return ""
  }
  
  func containsRegexpMatch(ofPatthern patthern: String) -> Bool {
    guard self != "" else {return false}
    let expression = getRegularExpression(with: patthern)
    return (expression.0 != nil)
  }
  
  func replaceRegexpMatch(withPatthern patthern: String, and replacement: String) -> String {
    let expression = getRegularExpression(with: patthern)
    if let regex = expression.1,
       expression.0 != nil {
      let modifiedString = regex.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: self.count), withTemplate: replacement)
      return modifiedString
    }
    return self
  }
  
  fileprivate func getRegularExpression(with pattern: String) -> (NSTextCheckingResult?, NSRegularExpression?) {
    guard self != "" && pattern != "" else {return (nil, nil)}
    
    let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    
    if let match = regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) {
      return (match, regex)
    }
    return (nil, nil)
  }
  
  //MARK: - Substring
  func substring(with nsrange: NSRange) -> Substring? {
    guard let range = Range(nsrange, in: self) else { return nil }
    return self[range]
  }
  
  //MARK: - VersionString
  func versionValue() -> Int {
    guard self != "" else {return 0}
    /* Create an array of components to get the right value */
    let numericComponents = self.components(separatedBy: ".")
    /* Variable to store result */
    var normalizedVersionString = ""
    /* Normalize each compoent */
    for numericComponent in numericComponents {
      /* Clears out all non numerical elements for the current component */
      var finalComponent = numericComponent.replaceRegexpMatch(withPatthern: "[-_\\.A-Za-z]*", and: "")
      /* The number has a single digit, then append a zero to the left */
      if (finalComponent.count == 1) {
        finalComponent = String(format: "0%@",finalComponent)
      }
      /* Stores the result for the current iteration */
      normalizedVersionString += finalComponent
    }
    
    let inVersionValue = Int(normalizedVersionString) ?? 0
    return inVersionValue
  }
  
  // MARK: -  json Utils
  func toDictionary() -> [String: AnyObject]? {
    let originalString = self
    if let data = originalString.data(using: .utf8) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
      } catch let error as NSError {
        print(error)
        return nil
      }
    }
    return nil
  }
  
  // MARK: -  Plist file
  /// Create a Dictionary from a local Plist
  /// - Important: This method could return nil
  ///
  /// - Returns: A Dictionary with all Data
  func plistFile() -> [NSString: NSString]? {
    
    let bundle = Bundle.main
    
    if let listPath = bundle.path(forResource: self, ofType: "plist") {
      
      guard let dataDictionary = NSDictionary(contentsOfFile: listPath),
            let pathDictionary = dataDictionary as? [NSString: NSString] else { return nil }
      
      return pathDictionary
      
    } else {
      return nil
    }
  }
  
  //MARK: Remove to URL
  mutating func removeValueToURL(valueToRemove: String) {
    guard let url = URL(string: self),
          var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
          let queryItems = urlComponents.queryItems else {
            return
          }
    
    let filterItems = queryItems.filter({$0.name != valueToRemove})
    urlComponents.queryItems = filterItems
    self = urlComponents.url?.absoluteString ?? self
  }
  
  /// Encodes or decodes into a base64url safe representation
  ///
  /// - Parameter on: Whether or not the string should be made safe for URL strings
  /// - Returns: if `on`, then a base64url string; if `off` then a base64 string
  func toggleBase64URLSafe(on: Bool) -> String {
    if on {
      // Make base64 string safe for passing into URL query params
      let base64url = replacingOccurrences(of: "/", with: "_")
        .replacingOccurrences(of: "+", with: "-")
        .replacingOccurrences(of: "=", with: "")
      return base64url
    } else {
      // Return to base64 encoding
      var base64 = replacingOccurrences(of: "_", with: "/")
        .replacingOccurrences(of: "-", with: "+")
      // Add any necessary padding with `=`
      if base64.count % 4 != 0 {
        base64.append(String(repeating: "=", count: 4 - base64.count % 4))
      }
      return base64
    }
  }
  
}

