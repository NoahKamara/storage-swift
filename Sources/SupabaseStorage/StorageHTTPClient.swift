import Foundation

public protocol StorageHTTPClient {
  /// This method is called when the ``SupabaseStorageClient`` needs load data from an request
  func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)

  /// This method is called when the ``SupabaseStorageClient`` needs upload data in an request
  func upload(_ request: URLRequest, from data: Data) async throws -> (Data, HTTPURLResponse)
}

public struct DefaultStorageHTTPClient: StorageHTTPClient {
  public init() {}

  public func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
    let (data, response) = try await URLSession.shared.data(for: request)

    guard let response = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }

    return (data, response)
  }

  public func upload(_ request: URLRequest, from data: Data) async throws -> (Data, HTTPURLResponse) {
    let (data, response) = try await URLSession.shared.upload(for: request, from: data)

    guard let response = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }

    return (data, response)
  }
}
