//
//  GitHubAPI.swift
//
//
//  Created by Shagun Madhikarmi on 02/10/2019.
//

import Foundation

public class GitHubAPI {
    
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    
    // MARK: - Initialisers
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    // MARK: - Get Search Results
    
    public func getSearchResults(term: String, completion: (([GitHubSearchResult], Error?) -> Void)?) {
        
        let url = URL(string: "https://api.github.com/search/repositories?q=\(term)")!
        let task = session.dataTask(with: url) { (data, response, urlError) in
            DispatchQueue.main.async {
                var results: [GitHubSearchResult] = []
                var error: Error?
            
                if let urlError = urlError {
                    error = GitHubSearchResultError.network(urlError)
                }
                else if let jsonData = data {
                    do {
                        let searchResponse = try self.decoder.decode(GitHubSearchResponse.self, from: jsonData)
                        results = searchResponse.items
                    } catch let jsonError {
                        error = GitHubSearchResultError.parsingData(jsonError)
                    }
                } else {
                    error = GitHubSearchResultError.emptyData
                }
                completion?(results, error)
            }
        }
        task.resume()
    }
}


