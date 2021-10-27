//
//  SearchResultLinealPredictive.swift
//  ClaroVideoServices
//
//  Created by Juan Carlos  Carrera on 09/06/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public struct SearchResultLinealPredictive: Decodable {
  enum CodingKeys: String, CodingKey {
    case suggest
    case prediction
    case contenidos
    case talents = "talentos"
  }

  public let suggest: [Group]?
  public let prediction: SearchPredictionResult?
  public let contenidos: [Group]?
  public let talents: TalentPredictive?

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let _suggest = try? values.decode(CommonObject.self, forKey: .suggest)
    self.suggest = _suggest?.common
    self.prediction = try? values.decode(SearchPredictionResult.self, forKey: .prediction)
    self.contenidos = try? values.decode([Group].self, forKey: .contenidos)
    self.talents = try? values.decode(TalentPredictive.self, forKey: .talents)
  }

}
  public struct CommonObject: Decodable {
    public let common: [Group]?
  }

  public struct TalentPredictive: Decodable {
    public let talents: ShortTalet?
    public let externalTalents: GracenoteObject?

    enum CodingKeys: String, CodingKey {
      case talents
      case externalTalents = "external_talents"
    }
    public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      self.talents = try? values.decode(ShortTalet.self, forKey: .talents)
      self.externalTalents = try? values.decode(GracenoteObject.self, forKey: .externalTalents)
    }
  }

  public struct GracenoteObject: Decodable {
    public let gracenote: [Talent]?
  }

  public struct ShortTalet: Decodable {
    public let talent: [Talent]?
  }
