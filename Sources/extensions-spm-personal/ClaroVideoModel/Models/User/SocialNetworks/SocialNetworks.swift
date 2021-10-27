//
//  SocialNetworks.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class SocialNetworks: NSObject {
  public var idUsuario: String?
  public var idUsuarioSocial: String?
  public var redSocial: String?
  var extraData: SocialData?
  
  // MARK: - Instance Methods
  public override init() {
    self.idUsuario = nil
    self.idUsuarioSocial = nil
    self.redSocial = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    idUsuario = try container.decodeIfPresent(String.self, forKey: .idUsuario)
    idUsuarioSocial = try container.decodeIfPresent(String.self, forKey: .idUsuarioSocial)
    redSocial = try container.decodeIfPresent(String.self, forKey: .redSocial)
    extraData = try? container.decodeIfPresent(SocialData.self, forKey: .extraData)
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(idUsuario, forKey: .idUsuario)
    try codingKeys.encode(idUsuarioSocial, forKey: .idUsuarioSocial)
    try codingKeys.encode(redSocial, forKey: .redSocial)
    try codingKeys.encode(extraData, forKey: .extraData)
  }

}
