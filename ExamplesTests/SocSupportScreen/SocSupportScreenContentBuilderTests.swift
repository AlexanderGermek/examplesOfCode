//
//  SocSupportScreenContentBuilderTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

import XCTest
@testable import PayrollCard

final class SocSupportScreenContentBuilderTests: XCTestCase {
	private var sut: SocSupportScreenContentBuilder!
	private var delegateSpy: SocSupportScreenPresenterSpy!

	// MARK: - Setup
	override func setUp() {
		super.setUp()
		delegateSpy = SocSupportScreenPresenterSpy()
		sut = SocSupportScreenContentBuilder()
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
		let model = SocSupportScreenInteractorTests.makeBottomSheetModel()
		var isDisclosureItemTappedCalled = false
		delegateSpy.itemTappedStub = {
			isDisclosureItemTappedCalled = true
		}

		// act
		let formItems = sut.makeItems(model: model)

		_ = formItems.compactMap { $0 as? DSNDisclosureCellFormItem }.map { $0.actionBlock?() }

		// assert
		XCTAssertTrue(isDisclosureItemTappedCalled)
		XCTAssertTrue(formItems.first is SectionHeaderFormItem)
		XCTAssertTrue(formItems.last is HintBanner.ItemType)
	}
}
