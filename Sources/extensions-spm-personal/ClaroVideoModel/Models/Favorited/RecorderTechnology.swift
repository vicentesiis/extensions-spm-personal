

import Foundation

public final class RecorderTechnology : NSObject {
    public var id: String?
    public var descriptions: String?
    
    public override init() {
      self.id = nil
      self.descriptions = nil
    }
    
    required convenience public init(from decoder: Decoder) throws {
      self.init()
      let container = try decoder.container(keyedBy: CodingKeys.self)
      id = try container.decodeIfPresent(String.self, forKey: .id)
      descriptions = try container.decodeIfPresent(String.self, forKey: .descriptions)
    }
}
