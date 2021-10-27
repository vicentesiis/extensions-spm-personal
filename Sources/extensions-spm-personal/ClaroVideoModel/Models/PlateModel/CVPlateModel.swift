//
//  CVPlateModel.swift
//  ClaroVideoServices
//
//  Created by Adrián Salazar G on 06/11/20.
//  Copyright © 2020 amco. All rights reserved.
//

import UIKit

public enum CVPlateType: String {
    case unkown, image, label
}

public enum CVGravityPlateType {
    case left, right
}

#if os(iOS)
let CVMaximumSizeFont = 13.0
#endif

public struct CVPlateModel: Decodable {
  
  public var plateType: CVPlateType
  public var text: String?
  public var gravityPlateType: CVGravityPlateType
  public var backGroundColor: UIColor?
  public var textColor: UIColor?
  public var textSize: Double
  public var iconWidth: Double
  public var iconHeight: Double
  public var iconUrl: URL?
  public var plateKey: String?
 
  init() {
    plateType = .unkown
    gravityPlateType = .left
    textSize = 0
    iconWidth = 0
    iconHeight = 0
  }
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case type = "type"
    case gravity = "gravity"
    case text = "text"
    case url = "url"
    case width = "width"
    case height = "height"
    case backgroundColor = "backgroundColor"
    case textColor = "textColor"
    case textSize = "textSize"
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let type = try container.decodeIfPresent(String.self, forKey: .type) {
      switch type {
        case "image":
          plateType = .image
        case "text":
          plateType = .label
        default:
          plateType = .unkown
      }
    }
    if let gravity = try? container.decodeIfPresent(String.self, forKey: .gravity) {
      gravityPlateType = gravity == "right" ? .right : .left
    }
    if let keyString = try? container.decodeIfPresent(String.self, forKey: .text) {
        text = keyString
    }
    if let url = try? container.decodeIfPresent(String.self, forKey: .url),
       plateType == .image {
      iconUrl = URL(string: url)
    }
    if let widthString = try? container.decodeIfPresent(String.self, forKey: .width),
       let widthDouble = Double(widthString) {
      iconWidth = widthDouble
    } else if let widthValue = try? container.decodeIfPresent(Double.self, forKey: .width) {
      iconWidth = widthValue
    }
    if let heightString = try? container.decodeIfPresent(String.self, forKey: .height),
       let heightDouble = Double(heightString) {
      iconHeight = heightDouble
    } else if let heightValue = try? container.decodeIfPresent(Double.self, forKey: .height) {
      iconHeight = heightValue
    }
    if let textSizeString = try? container.decodeIfPresent(String.self, forKey: .textSize),
       let textSizeStringDouble = Double(textSizeString) {
      #if os(iOS)
      textSize = textSizeStringDouble > CVMaximumSizeFont ? CVMaximumSizeFont : textSizeStringDouble
      #else
      textSize = textSizeStringDouble
      #endif
    } else if let textSizeValue = try container.decodeIfPresent(Double.self, forKey: .textSize) {
      #if os(iOS)
      textSize = textSizeValue > CVMaximumSizeFont ? CVMaximumSizeFont : textSizeValue
      #else
      textSize = textSizeValue
      #endif
    }
    if let backGroundColor = try? container.decodeIfPresent(String.self, forKey: .backgroundColor) {
      self.backGroundColor = UIColor.color(hexString: backGroundColor)
    }
    if let textColorString = try? container.decodeIfPresent(String.self, forKey: .textColor) {
      textColor = UIColor.color(hexString: textColorString)
    }
    
  }
  
}

extension CVPlateModel: Parceable {
  
  public static func parsePLateModel(dictionary: [String : Any], plateKey: String) -> CVPlateModel? {
    let plateModel = parseObject(dictionary: dictionary)
    switch plateModel {
      case .success(var plateModel):
        plateModel.plateKey = plateKey
        return plateModel
      case .failure:
        return nil
    }
  }
  
  public static func parseObject(dictionary: [String : Any]) -> Result<CVPlateModel, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
      
      let cvPlateModel = try JSONDecoder().decode(CVPlateModel.self, from: jsonData)
      return .success(cvPlateModel)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}
