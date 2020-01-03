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
    
    public init(id: Int, full_name: String, description: String, html_url: URL, stargazers_count: Int, watchers_count: Int) {
        self.id = id
        self.full_name = full_name
        self.description = description
        self.html_url = html_url
        self.stargazers_count = stargazers_count
        self.watchers_count = watchers_count
    }    
}
