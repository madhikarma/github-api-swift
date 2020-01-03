//
//  GitHubSearchResultError.swift
//  
//
//  Created by Shagun Madhikarmi on 31/12/2019.
//

import Foundation

public enum GitHubSearchResultError: Error {
    case emptyData
    case parsingData(Error?)
    case unknown(Error?)
}
