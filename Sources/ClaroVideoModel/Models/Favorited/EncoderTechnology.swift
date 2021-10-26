

import Foundation

public final class EncoderTechnology : NSObject, NSCoding {
  
    public var id: String?
    public var descriptions: String?
    
    public override init() {
      self.id = nil
      self.descriptions = nil
    }
  
    public func encode(with coder: NSCoder) {
      let coding = CodingKeys.self
      
      coder.encode(id, forKey: coding.id.rawValue)
      coder.encode(descriptions, forKey: coding.descriptions.rawValue)
    }

    public convenience init?(coder: NSCoder) {
      let coding = CodingKeys.self
      
      let idDecode = coder.decodeObject(forKey: coding.id.rawValue) as? String
      let descriptionDecode = coder.decodeObject(forKey: coding.descriptions.rawValue) as? String
      self.init()
      self.id = idDecode
      self.descriptions = descriptionDecode
    }
    
    required convenience public init(from decoder: Decoder) throws {
      self.init()
      let container = try decoder.container(keyedBy: CodingKeys.self)
      if let idDecode = try? container.decode(String.self, forKey: .id) {
        id = idDecode
      }
      if let descriptionsDecode = try? container.decode(String.self, forKey: .descriptions) {
        descriptions = descriptionsDecode
      }
    }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(id, forKey: .id)
    try codingKeys.encode(description, forKey: .descriptions)
  }
}
