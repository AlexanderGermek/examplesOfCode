//
//  SpecialOpportunitiesInteractorTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 25.07.2022.
// 
//

import XCTest
@testable import PayrollCard

final class SpecialOpportunitiesInteractorTests: XCTestCase {
	private var interactor: SpecialOpportunitiesInteractor!
	private var analyticsSpy: AnalyticsSpy!
	private var networkServiceMock: SocialOpportunitiesNetworkServiceMock!

	// MARK: - Setup
	override func setUp() {
		super.setUp()
		analyticsSpy = AnalyticsSpy()
		networkServiceMock = SocialOpportunitiesNetworkServiceMock()
		interactor = SpecialOpportunitiesInteractor(analytics: analyticsSpy, networkService: networkServiceMock)
	}

	override func tearDown() {
		analyticsSpy = nil
		networkServiceMock = nil
		interactor = nil
		super.tearDown()
	}

	// MARK: - Tests
	func testThatFetchDataWasFail() {
		// arrange
		networkServiceMock.loadedError = true
		var wasFail = false

		// act
		interactor.fetchData { result in
			wasFail = result == nil
		}

		// assert
		XCTAssertTrue(networkServiceMock.loadExecuted)
		XCTAssertTrue(wasFail)
	}

	func testThatFetchDataWasSuccess() {
		// arrange
		networkServiceMock.loadedError = false
		var wasSuccess = false

		// act
		interactor.fetchData { result in
			wasSuccess = result != nil
		}

		// assert
		XCTAssertTrue(networkServiceMock.loadExecuted)
		XCTAssertTrue(wasSuccess)
	}

	func testThatAnalyticsSend() {
		// arrange
		let testString = "testString"

		// act
		interactor.sendAnalytic(event: testString)

		// assert
		XCTAssertTrue(analyticsSpy.eventNames.contains(testString))
	}
}
