//
//  SpecialOpportunitiesRouterTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 26.07.2022.
// 
//

import XCTest
@testable import PayrollCard

final class SpecialOpportunitiesRouterTests: XCTestCase {
	private var router: SpecialOpportunitiesRouter!
	private var sbfRouter: SBFTransitionRouterSpy!
	private var navigationController: NavigationControllerMock!
	private var viewMock: SpecialOpportunitiesViewMock!

	// MARK: - Setup
	override func setUp() {
		super.setUp()
		sbfRouter = SBFTransitionRouterSpy()
		navigationController = NavigationControllerMock()
		viewMock = SpecialOpportunitiesViewMock()
		router = SpecialOpportunitiesRouter(view: viewMock,
											router: sbfRouter,
											navigationController: navigationController)
	}

	override func tearDown() {
		sbfRouter = nil
		navigationController = nil
		viewMock = nil
		router = nil
		super.tearDown()
	}

	// MARK: - Tests
	func testOpenThatURLPathIsNil() {
		// arrange
		let urlPath: String? = nil

		// act
		router.open(urlPath: urlPath)

		// assert
		XCTAssertNil(sbfRouter.isDeeplinkAvailableUrlPath)
		XCTAssertFalse(sbfRouter.isDeeplinkAvailableCalled)
	}

	func testThatCanOpenDeeplink() {
		// arrange
		let urlPath: String = ""

		// act
		router.open(urlPath: urlPath)

		// assert
		XCTAssertEqual(sbfRouter.isDeeplinkAvailableUrlPath, urlPath)
		XCTAssertTrue(sbfRouter.isDeeplinkAvailableCalled)
		XCTAssertEqual(sbfRouter.prepareTransitionUrlPath, "openitsolutionsonline://" + urlPath)
		XCTAssertTrue(sbfRouter.prepareTransitionCalled)
	}

	func testThatPresentViewController() {
		// arrange
		let testTitle = "Test title"
		let testVC = UIViewController()
		testVC.title = testTitle
		var isStopLoaderCalled = false
		var isPresentCalled = false
		viewMock.stopLoaderStub = { isStopLoaderCalled = true }
		navigationController.presentStub = { viewController in
			isPresentCalled = viewController.title == testTitle
		}

		// act
		router.presentErrorAlertController(testVC)

		// assert
		XCTAssertTrue(isStopLoaderCalled)
		XCTAssertTrue(isPresentCalled)
	}

	func testThatDismissPresentedControllerWithShouldToPop() {
		// arrange
		var isDismissCalled = false
		var isPopViewControllerCalled = false

		navigationController.dismissStub = { isDismissCalled = true }
		navigationController.popViewControllerStub = {
			isPopViewControllerCalled = true
			return nil
		}

		// act
		router.dismissPresentedController(shouldToPop: true)

		// assert
		XCTAssertTrue(isDismissCalled)
		XCTAssertTrue(isPopViewControllerCalled)
	}

	func testThatDismissPresentedControllerWithoutShouldToPop() {
		// arrange
		var isDismissCalled = false
		var isPopViewControllerCalled = false

		navigationController.dismissStub = { isDismissCalled = true }
		navigationController.popViewControllerStub = {
			isPopViewControllerCalled = true
			return nil
		}

		// act
		router.dismissPresentedController(shouldToPop: false)

		// assert
		XCTAssertTrue(isDismissCalled)
		XCTAssertFalse(isPopViewControllerCalled)
	}
}
