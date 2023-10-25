import Foundation


public struct BucketOptions {
	/// Anyone can read any object without any authorization
	public let `public`: Bool
	
	/// Prevent uploading of file sizes greater than a specified limit
	public let fileSizeLimit: Int?
	
	/// Allowed MIME types
	public let allowedMimeTypes: [String]?
	
	/// Options for creating a bucket
	/// - Parameters:
	///   - public: Anyone can read any object without any authorization
	///   - fileSizeLimit: Prevent uploading of file sizes greater than a specified limit
	///   - allowedMimeTypes: Allowed MIME types
	public init(public: Bool = false, fileSizeLimit: Int? = nil, allowedMimeTypes: [String]? = nil) {
		self.public = `public`
		self.fileSizeLimit = fileSizeLimit
		self.allowedMimeTypes = allowedMimeTypes
	}
}
