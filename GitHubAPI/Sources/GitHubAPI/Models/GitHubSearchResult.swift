//
//  GitHubSearchResult.swift
//
//
//  Created by Shagun Madhikarmi on 02/10/2019.
//

import Foundation

struct GitHubSearchResult: Identifiable, Codable {
    let id: Int
    let full_name: String
    let description: String
    let html_url: URL
    let stargazers_count: Int
    let watchers_count: Int
}
