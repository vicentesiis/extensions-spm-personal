//
//  Node+Decodable.swift
//  ClaroVideoServices
//
//  Created by Alejandro Hernandez Tapia on 10/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Node: Parceable, Codable {
  public static func parseObject(dictionary: [String : Any]) -> Result<Node, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      let launcher = try JSONDecoder().decode(Node.self, from: jsonData)
      return .success(launcher)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
  public static func parseArrayObject(dictionary: [[String: Any]]) -> Result<[Node], NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      let launcher = try JSONDecoder().decode([Node].self, from: jsonData)
      return .success(launcher)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
  // MARK: - Coding Keys
  enum Nodekeys: String, CodingKey {
    case id
    case parentId = "id_parent"
    case code
    case text
    case iconURL = "icon"
    case menuId = "menu_id"
    case imageURL = "image"
    case imageOverURL = "image_over"
    case recommendationsURL = "url_recommendations"
    case colorKey
    case level
    case type
    case order
    case status
    case appBehaviour = "app_behaviour"
    case childs
  }
}
