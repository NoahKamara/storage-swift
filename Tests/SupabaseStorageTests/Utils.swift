//
//  File.swift
//  
//
//  Created by Noah Kamara on 25.10.23.
//

import Foundation

import Foundation
import XCTest

@testable import SupabaseStorage

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension SupabaseStorageClient {
	static func testClient() -> SupabaseStorageClient {
		let apiKey: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU"
		
		let supabaseURL: String = "http://localhost:54321/storage/v1"
		
		return SupabaseStorageClient(
			url: supabaseURL,
			headers: [
				"Authorization": "Bearer \(apiKey)",
				"apikey": apiKey,
			]
		)
	}
}
