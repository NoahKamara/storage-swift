public struct Bucket: Hashable, Codable {
	public typealias ID = String
	
  public var id: ID
  public var name: String
  public var owner: String
  public var isPublic: Bool
  public var createdAt: String
  public var updatedAt: String

  init?(from dictionary: [String: Any]) {
    guard
      let id = dictionary["id"] as? String,
      let name = dictionary["name"] as? String,
      let owner = dictionary["owner"] as? String,
      let createdAt = dictionary["created_at"] as? String,
      let updatedAt = dictionary["updated_at"] as? String,
      let isPublic = dictionary["public"] as? Bool
    else {
      return nil
    }

    self.id = id
    self.name = name
    self.owner = owner
    self.isPublic = isPublic
    self.createdAt = createdAt
    self.updatedAt = updatedAt
  }
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case owner
		case isPublic = "public"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}

struct AssociatedValue<T:Decodable>: Decodable {
	let key: String
	let value: T
	
	struct CodingKeys: CodingKey {
		let stringValue: String
		let intValue: Int? = nil
		init(stringValue: String) {
			self.stringValue = stringValue
		}
		
		init?(intValue: Int) {
			return nil
		}
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let keyCount = container.allKeys.count
		
		guard keyCount == 1, let key = container.allKeys.first else {
			throw DecodingError.typeMismatch([String:Any].self, .init(codingPath: container.codingPath, debugDescription: "Expected one key, but found \(keyCount)"))
		}
		
		
		self.key = key.stringValue
		self.value = try container.decode(T.self, forKey: key)
	}
}
