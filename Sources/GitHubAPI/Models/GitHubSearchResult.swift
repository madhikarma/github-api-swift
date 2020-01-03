//
//  GitHubSearchResult.swift
//
//
//  Created by Shagun Madhikarmi on 02/10/2019.
//

import Foundation

public struct GitHubSearchResult: Identifiable, Codable {
    public let id: Int
    public let full_name: String
    public let description: String
    public let html_url: URL
    public let stargazers_count: Int
    public let watchers_count: Int
}
