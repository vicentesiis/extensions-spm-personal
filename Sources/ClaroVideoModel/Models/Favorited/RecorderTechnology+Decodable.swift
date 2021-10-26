//
//  DecoderTechnology+Decodable.swift
//  ClaroVideoServices
//
//  Created by Yoringuel Ruiz on 02/11/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension RecorderTechnology : Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case descriptions = "desc"
    }
}

