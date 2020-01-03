//
//  GitHubSearchResponse.swift
//
//
//  Created by Shagun Madhikarmi on 02/10/2019.
//

import Foundation

public struct GitHubSearchResponse: Codable {
    public let total_count: UInt
    public let items: [GitHubSearchResult]
}
