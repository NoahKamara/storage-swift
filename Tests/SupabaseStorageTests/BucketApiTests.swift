//
//  File.swift
//  
//
//  Created by Noah Kamara on 25.10.23.
//

import XCTest
import SupabaseStorage

class Tests: XCTestCase {
	let storage = SupabaseStorageClient.testClient()
	
	override func setUp() async throws {
		let buckets = try await storage.listBuckets()
		for bucket in buckets {
			try await storage.emptyBucket(id: bucket.id)
			try await storage.deleteBucket(id: bucket.id)
		}
	}
}

final class BucketApiTests: Tests {
	func testCreateBucket() async throws {
		let id = "test"
		let bucketID = try await storage.createBucket(id: id)
		XCTAssertEqual(id, bucketID)
	}
	
	func testCreatePublicBucket() async throws {
		let id = "test"
		try await storage.createBucket(id: id, options: .init(public: true))
		
		do {
			let bucket = try await storage.getBucket(id: id)
			print("BUCKET", bucket)
			XCTAssertEqual(id, bucket.id)
			XCTAssertTrue(bucket.isPublic)
		} catch {
			print(error)
			throw XCTSkip("Skipped because of error in `getBucket`")
		}
	}
	
	func testListBuckets() async throws {
		let id = "test"
		
		do {
			try await storage.createBucket(id: id)
		} catch {
			print(error)
			throw XCTSkip("Skipped because of error in `createBucket`")
		}
		
		let buckets = try await storage.listBuckets()
		XCTAssertEqual(buckets.map(\.id), [id])
	}
	
	func testGetBucket() async throws {
		let id = "test"
		
		do {
			try await storage.createBucket(id: id)
		} catch {
			print(error)
			throw XCTSkip("Skipped because of error in `createBucket`")
		}
		
		let bucket = try await storage.getBucket(id: id)
		XCTAssertEqual(bucket.id, id)
	}
	
	func testEmptyBucket() async throws {
		let id = "test"
		
		do {
			try await storage.createBucket(id: id)
		} catch {
			print(error)
			throw XCTSkip("Skipped because of error in `createBucket`")
		}
		
		try await storage.emptyBucket(id: id)
	}
	
	func testDeleteBucket() async throws{
		let id = "test"
		
		do {
			try await storage.createBucket(id: id)
		} catch {
			print(error)
			throw XCTSkip("Skipped because of error in `createBucket`")
		}
		
		try await storage.deleteBucket(id: id)
	}
}
