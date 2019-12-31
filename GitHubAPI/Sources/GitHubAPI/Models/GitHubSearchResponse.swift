//
//  GitHubSearchResponse.swift
//
//
//  Created by Shagun Madhikarmi on 02/10/2019.
//

import Foundation

struct GitHubSearchResponse: Codable {
    let total_count: UInt
    let items: [GitHubSearchResult]
}
