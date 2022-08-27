//
//  SocSupportScreenPresenterTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

import XCTest
@testable import PayrollCard

final class SocSupportScreenPresenterTests: XCTestCase {
	private var sut: SocSupportScreenPresenter!
	private var view: SocSupportScreenViewSpy!
	private var interactor: SocSupportScreenInteractorSpy!
	private var router: SocSupportScreenRouterSpy!
	private var contentBuilder: SocSupportScreenContentBuilderSpy!

	// MARK: - Setup
	override func setUp() {
		super.setUp()
		view = SocSupportScreenViewSpy()
		interactor = SocSupportScreenInteractorSpy()
		router = SocSupportScreenRouterSpy()
		contentBuilder = SocSupportScreenContentBuilderSpy()
		sut = SocSupportScreenPresenter(view: view,
										interactor: interactor,
										router: router,
										contentBuilder: contentBuilder)
	}

	override func tearDown() {
		view = nil
		interactor = nil
		router = nil
		contentBuilder = nil
		sut = nil
		super.tearDown()
	}

	// MARK: - Tests
	func testThatDidLoadView() {
		// arrange
		var isShowCalled = false
		view.showStub = { isShowCalled = true }

		// act
		sut.didLoadView()

		// assert
		XCTAssertTrue(isShowCalled)
	}

	// MARK: - SocSupportScreenContentBuilderDelegate Tests
	func testThatItemTapped() {
		// arrange
		let testURL = "testURL"
		let testEventForAnalytic = "testEvent"
		var isSendAnalyticCalled = false
		interactor.sendAnalyticStub = { event in
			isSendAnalyticCalled = testEventForAnalytic == event
		}
		var isGetValueLauncherCalled = false
		interactor.getValueLauncherStub = { key in
			isGetValueLauncherCalled = testURL == key
			return key
		}

		var isOpenCalled = false
		router.openStub = { url in
			isOpenCalled = testURL == url
		}

		// act
		sut.itemTapped(testURL, testEventForAnalytic)

		// assert
		XCTAssertTrue(isSendAnalyticCalled)
		XCTAssertTrue(isGetValueLauncherCalled)
		XCTAssertTrue(isOpenCalled)
	}
}
