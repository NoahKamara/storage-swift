public struct FileObject: Codable {
  public var name: String
  public var bucketId: String?
  public var owner: String?
  public var id: String
  public var updatedAt: String
  public var createdAt: String
  public var lastAccessedAt: String
//  public var metadata: [String: Any]
  public var buckets: Bucket?

	
	enum CodingKeys: String, CodingKey {
		case name
		case bucketId
		case owner
		case id
		case updatedAt = "updated_at"
		case createdAt = "created_at"
		case lastAccessedAt = "last_accessed_at"
//		case metadata
		case buckets
	}
}
