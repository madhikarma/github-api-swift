import XCTest
@testable import GitHubAPI

final class GitHubAPITests: XCTestCase {
    
    func testGetSearchResults() {
        
        // Given
        let gitHubAPI = GitHubAPI()
        let expectation = XCTestExpectation()
        
        // When
        gitHubAPI.getSearchResults(term: "swift") { result in
            expectation.fulfill()
            // Then            
            switch result {
            case .success(let items):
                print("search success: \(items)")
                XCTAssertFalse(items.isEmpty)
            case .failure(let error):
                XCTFail("Error: expected search results but instead there was an error: \(error)")
            }

        }
        XCTWaiter().wait(for: [expectation], timeout: 5)
    }

    static var allTests = [
        ("testGetSearchResults", testGetSearchResults),
    ]
}
