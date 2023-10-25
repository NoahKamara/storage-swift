import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif
import UniformTypeIdentifiers

extension URL {
	func appending(component: String) -> URL {
		self.appendingPathComponent(component)
	}
	
	func appending(components: String...) -> URL {
		components.reduce(self, { $0.appendingPathComponent($1) })
	}
}

/// Storage Bucket API
public class StorageBucketApi: StorageApi {
  /// StorageBucketApi initializer
  /// - Parameters:
  ///   - url: Storage HTTP URL
  ///   - headers: HTTP headers.
  override init(url: String, headers: [String: String], http: StorageHTTPClient) {
    super.init(url: url, headers: headers, http: http)
    self.headers.merge(["Content-Type": "application/json"]) { $1 }
  }

  /// Retrieves the details of all Storage buckets within an existing product.
  public func listBuckets() async throws -> [Bucket] {
	  let url = realURL.appending(component: "bucket")

	  return try await fetch(
		url: url,
		method: .get,
		parameters: nil,
		headers: headers
	  )
  }

  /// Retrieves the details of an existing Storage bucket.
  /// - Parameters:
  ///   - id: The unique identifier of the bucket you would like to retrieve.
  public func getBucket(id: String) async throws -> Bucket {
	  let url = realURL.appending(components: "bucket", id)

    return try await fetch(url: url, method: .get, parameters: nil, headers: headers)
  }

	/// Creates a new Storage bucket
	/// - Parameters:
	///   - id: A unique identifier for the bucket you are creating.
	///   - options: Bucket Options
	/// - Returns: The unique identifier of the created bucket
	@discardableResult
  public func createBucket(
    id: String,
    options: BucketOptions = .init()
  ) async throws -> Bucket.ID {
	  let url = realURL.appending(component: "bucket")

    var params: [String: Any] = [
      "id": id,
      "name": id,
    ]

    params["public"] = options.public
    params["file_size_limit"] = options.fileSizeLimit
    params["allowed_mime_types"] = options.allowedMimeTypes

	  return try await fetch(
		url: url,
		method: .post,
		parameters: params,
		headers: headers,
		as: AssociatedValue<String>.self
	  ).value
  }

  /// Removes all objects inside a single bucket.
  /// - Parameters:
  ///   - id: The unique identifier of the bucket you would like to empty.
  @discardableResult
  public func emptyBucket(id: String) async throws -> [String: Any] {
	  let url = realURL.appending(components: "bucket", id, "empty")

    let response = try await fetch(url: url, method: .post, parameters: [:], headers: headers)
    guard let dict = response as? [String: Any] else {
      throw StorageError(message: "failed to parse response")
    }
    return dict
  }

  /// Deletes an existing bucket. A bucket can't be deleted with existing objects inside it.
  /// You must first `empty()` the bucket.
  /// - Parameters:
  ///   - id: The unique identifier of the bucket you would like to delete.
  @discardableResult
  public func deleteBucket(id: String) async throws -> [String: Any] {
	  let url = realURL.appending(components: "bucket", id)

    let response = try await fetch(url: url, method: .delete, parameters: [:], headers: headers)
	  
    guard let dict = response as? [String: Any] else {
      throw StorageError(message: "failed to parse response")
    }
    return dict
  }
}
