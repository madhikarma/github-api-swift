//
//  GitHubAPI.swift
//
//
//  Created by Shagun Madhikarmi on 02/10/2019.
//

import Combine
import Foundation

public class GitHubAPI {
    fileprivate let session: URLSession
    fileprivate let decoder: JSONDecoder

    // MARK: - Initialisers

    public init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    // MARK: - Get Search Results

    @discardableResult
    public func getSearchResults(term: String, completion: @escaping (Result<[GitHubSearchResult], GitHubSearchResultError>) -> Void) -> URLSessionTask {
        let url = makeSearchURL(term)
        let task = session.dataTask(with: url) { data, _, urlError in
            let result = self.parseResponse(data: data, error: urlError)
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
        return task
    }

    // MARK: - Private

    fileprivate func parseResponse(data: Data?, error: Error?) -> Result<[GitHubSearchResult], GitHubSearchResultError> {
        if let urlError = error {
            return .failure(GitHubSearchResultError.unknown(urlError))
        }

        guard let jsonData = data else {
            return .failure(GitHubSearchResultError.emptyData)
        }

        do {
            let searchResponse = try decoder.decode(GitHubSearchResponse.self, from: jsonData)
            return .success(searchResponse.items)
        } catch let jsonError {
            return .failure(GitHubSearchResultError.parsingData(jsonError))
        }
    }

    fileprivate func makeSearchURL(_ term: String) -> URL {
        return URL(string: "https://api.github.com/search/repositories?q=\(term)")!
    }
}

// MARK: - Combine

extension GitHubAPI {
    
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    public func getSearchResults(_ term: String) -> AnyPublisher<GitHubSearchResponse, Error> {
        let url = makeSearchURL(term)
        let publisher = session.dataTaskPublisher(for: url)
            .map { $0.data }
            .tryMap { (data) -> GitHubSearchResponse in
                try self.decoder.decode(GitHubSearchResponse.self, from: data)
            }.eraseToAnyPublisher()
        return publisher
    }
}
