//
//  SocialNetworks+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension SocialNetworks: Codable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case idUsuario = "id_usuario"
    case idUsuarioSocial = "id_usuario_social"
    case redSocial = "redsocial"
    case extraData = "extra_data"
  }
}
