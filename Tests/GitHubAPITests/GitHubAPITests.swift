import Combine
@testable import GitHubAPI
import XCTest

@available(iOS 13.0, *)
@available(OSX 10.15, *)
final class GitHubAPITests: XCTestCase {
    private var cancellableSet: Set<AnyCancellable> = []

    override func tearDown() {
        super.tearDown()
        cancellableSet.forEach { cancellable in
            cancellable.cancel()
        }
    }

    func testGetSearchResults() {
        // Given
        let gitHubAPI = GitHubAPI()
        let expectation = XCTestExpectation()

        // When
        gitHubAPI.getSearchResults(term: "swift") { result in
            expectation.fulfill()
            // Then
            switch result {
            case let .success(items):
                print("search success: \(items)")
                XCTAssertFalse(items.isEmpty)
            case let .failure(error):
                XCTFail("Error: expected search results but instead there was an error: \(error)")
            }
        }
        XCTWaiter().wait(for: [expectation], timeout: 1)
    }

    func testGetSearchResponse() {
        // Given
        let gitHubAPI = GitHubAPI()
        let expectation = XCTestExpectation()

        gitHubAPI.getSearchResults("swift")
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        XCTFail("Error: expected search results but instead there was an error: \(error)")
                    default:
                        break
                    }
                }, receiveValue: { someValue in
                    XCTAssertNotNil(someValue)
                }
            )
            .store(in: &cancellableSet)
        XCTWaiter().wait(for: [expectation], timeout: 1)
    }

    static var allTests = [
        ("testGetSearchResults", testGetSearchResults)
    ]
}
