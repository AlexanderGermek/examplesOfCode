//
//  SocSupportScreenRouterTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

import XCTest
@testable import PayrollCard

final class SocSupportScreenRouterTests: XCTestCase {
	private var sut: SocSupportScreenRouter!
	private var sbfRouter: SBFTransitionRouterSpy!
	private var navigationController: NavigationControllerMock!

	// MARK: - Setup
	override func setUp() {
		super.setUp()
		sbfRouter = SBFTransitionRouterSpy()
		navigationController = NavigationControllerMock()
		sut = SocSupportScreenRouter(appRouter: sbfRouter,
									 navigationController: navigationController)
	}

	override func tearDown() {
		sbfRouter = nil
		navigationController = nil
		sut = nil
		super.tearDown()
	}

	func testOpenWithNilOrEmpty() {
		// arrange
		let testCases: [String?] = ["", nil]

		// act
		testCases.forEach {
			sut.open(urlPath: $0)

			// assert
			XCTAssertFalse(sbfRouter.isDeeplinkAvailableCalled)
			XCTAssertFalse(sbfRouter.isUrlPathAvailableCalled)
		}
	}

	func testThatOpenDeeplink() {
		// arrange
		let urlPath: String = ""

		// act
		sut.open(urlPath: urlPath)

		// assert
		XCTAssertEqual(sbfRouter.isDeeplinkAvailableUrlPath, urlPath)
		XCTAssertTrue(sbfRouter.isDeeplinkAvailableCalled)
		XCTAssertEqual(sbfRouter.prepareTransitionUrlPath, "openitsolutionsonline://" + urlPath)
		XCTAssertTrue(sbfRouter.prepareTransitionCalled)
	}

	func testThatOpenInSafari() {
		// arrange
		let urlPath: String = ""
		sbfRouter.isDeeplinkAvailable = false
		var isDismissWithCompletionCalled = false
		navigationController.dismissWithCompletionStub = { isDismissWithCompletionCalled = true }

		// act
		sut.open(urlPath: urlPath)

		// assert
		XCTAssertTrue(sbfRouter.isDeeplinkAvailableCalled)
		XCTAssertEqual(sbfRouter.isDeeplinkAvailableUrlPath, urlPath)
		XCTAssertTrue(sbfRouter.isUrlPathAvailableCalled)
		XCTAssertEqual(sbfRouter.isUrlPathAvailableUrlPath, urlPath)
		XCTAssertFalse(sbfRouter.prepareTransitionCalled)
		XCTAssertTrue(isDismissWithCompletionCalled)
	}
}
