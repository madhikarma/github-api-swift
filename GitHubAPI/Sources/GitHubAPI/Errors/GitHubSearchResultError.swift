//
//  GitHubSearchResultError.swift
//  
//
//  Created by Shagun Madhikarmi on 31/12/2019.
//

import Foundation

enum GitHubSearchResultError: Error {
    case parsingData(Error?)
    case emptyData
    case network(Error?)
    case unknown(Error?)
}
