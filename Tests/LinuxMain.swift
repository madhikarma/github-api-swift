import XCTest

import GitHubAPITests

var tests = [XCTestCaseEntry]()
tests += GitHubAPITests.allTests()
XCTMain(tests)
