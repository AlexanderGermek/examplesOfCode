//
//  SpecialOpportunitiesContentBuilderTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 27.07.2022.
//
//

import XCTest
@testable import PayrollCard

final class SpecialOpportunitiesContentBuilderTests: XCTestCase {
	private var delegateSpy: SpecialOpportunitiesPresenterSpy!
	private var sut: SpecialOpportunitiesContentBuilder!

	override func setUp() {
		super.setUp()
		delegateSpy = SpecialOpportunitiesPresenterSpy()
		sut = SpecialOpportunitiesContentBuilder()
		sut.delegate = delegateSpy
	}

	override func tearDown() {
		delegateSpy = nil
		sut = nil
		super.tearDown()
	}

	// MARK: - Tests

	func testThatMakeItems() {
		// arrange
		let networkService = SocialOpportunitiesNetworkServiceMock()
		networkService.loadedError = false
		var model: SpecialOpportunitiesBodyModel?
		networkService.loadSpecialOpportunities { result in
			guard case let .success(result) = result else { return }
			model = result.body
		}

		// act
		guard let model = model else {
			XCTFail("Model didn't initialize!")
			return
		}

		let items = sut.makeItemsFrom(model: model)

		var isItemTappedCalled = false
		delegateSpy.itemTappedStub = {
			isItemTappedCalled = true
		}

		_ = items.compactMap { $0 as? RichCell.Base.ItemType }
			.map { $0.model }
			.map { $0.didTapCallback?($0) }

		// assert
		XCTAssertTrue(isItemTappedCalled)
		XCTAssertTrue(items.first is SectionHeaderFormItem)
		XCTAssertTrue(items.last is RichCell.Base.ItemType)
	}

	func testMakeErrorAlert() {
		// arrange

		// act
		let alertVC = sut.makeErrorAlert()

		// assert
		XCTAssertTrue(alertVC is RichAlertViewController)
	}
}
