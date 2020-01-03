//
//  GitHubAPI.swift
//
//
//  Created by Shagun Madhikarmi on 02/10/2019.
//

import Foundation

public class GitHubAPI {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    
    // MARK: - Initialisers
    
    public init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    
    // MARK: - Get Search Results
    
    @discardableResult
    public func getSearchResults(term: String, completion: @escaping (Result<[GitHubSearchResult], GitHubSearchResultError>) -> ()) -> URLSessionTask {
        
        let url = URL(string: "https://api.github.com/search/repositories?q=\(term)")!
        let task = session.dataTask(with: url) { (data, response, urlError) in
            let result = self.parseResponse(data: data, error: urlError)
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
        return task
    }
    
    
    
    // MARK: - Private
    
    private func parseResponse(data: Data?, error: Error?) -> Result<[GitHubSearchResult], GitHubSearchResultError> {

        if let urlError = error {
            return .failure(GitHubSearchResultError.unknown(urlError))
        }
               
        guard let jsonData = data else {
            return .failure(GitHubSearchResultError.emptyData)
        }
        
        do {
            let searchResponse = try decoder.decode(GitHubSearchResponse.self, from: jsonData)
            return .success(searchResponse.items)
        } catch (let jsonError) {
            return .failure(GitHubSearchResultError.parsingData(jsonError))
        }
    }

}


