import XCTest
@testable import GitHubAPI

final class GitHubAPITests: XCTestCase {
    
    func testGetSearchResults() {
        
        // Given
        let gitHubAPI = GitHubAPI()
        let expectation = XCTestExpectation()
        
        // When
        gitHubAPI.getSearchResults(term: "swift") { (results, error) in
            expectation.fulfill()
            // Then
            XCTAssertFalse(results.isEmpty)
            XCTAssertNil(error)
        }
        XCTWaiter().wait(for: [expectation], timeout: 5)
    }

    static var allTests = [
        ("testGetSearchResults", testGetSearchResults),
    ]
}
