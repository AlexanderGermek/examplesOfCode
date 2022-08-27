//
//  SocSupportScreenInteractorTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

import XCTest
@testable import PayrollCard

final class SocSupportScreenInteractorTests: XCTestCase {
	private var analyticsSpy: AnalyticsSpy!
	private var model: SocialSupportBottomSheetModel!
	private var launcher: UFSLauncherDecoderMock!
	private var sut: SocSupportScreenInteractor!

	// MARK: - Setup
	override func setUp() {
		super.setUp()
		analyticsSpy = AnalyticsSpy()
		model = Self.makeBottomSheetModel()
		launcher = UFSLauncherDecoderMock()
		sut = SocSupportScreenInteractor(analytics: analyticsSpy, model: model, launcher: launcher)
	}

	override func tearDown() {
		analyticsSpy = nil
		model = nil
		launcher = nil
		sut = nil
		super.tearDown()
	}

	// MARK: - Tests
	func testThatReturnModel() {
		// arrange

		// act
		let testModel = sut.returnModel()

		// assert
		XCTAssertEqual(testModel.title, "Соцподдержка")
		XCTAssertEqual(testModel.eventForAnalytic, "socialSupport")
		XCTAssertEqual(testModel.calculateSocialSupport.title, "Рассчитать социальные выплаты")
	}

	func testThatAnalyticsSend() {
		// arrange
		let testString = "testString"

		// act
		sut.sendAnalytic(event: testString)

		// assert
		XCTAssertTrue(analyticsSpy.eventNames.contains(testString))
	}

	func testThatGetNilFromLauncher() {
		// arrange
		let testKey: String? = nil
		var isGetValueFromOptionsCalled = false
		launcher.getValueFromOptionsStub = { key in
			isGetValueFromOptionsCalled = testKey == key
			return key
		}
		// act
		_ = sut.getValueLauncher(key: testKey)

		// assert
		XCTAssertFalse(isGetValueFromOptionsCalled)
	}

	func testThatGetValueFromLauncher() {
		// arrange
		let testKey = "Test Key"
		var isGetValueFromOptionsCalled = false
		launcher.getValueFromOptionsStub = { key in
			isGetValueFromOptionsCalled = testKey == key
			return key
		}
		// act
		let testKeyLauncher = sut.getValueLauncher(key: testKey)

		// assert
		XCTAssertTrue(isGetValueFromOptionsCalled)
		XCTAssertEqual(testKey, testKeyLauncher)
	}
}

// MARK: - TestData
extension SocSupportScreenInteractorTests {

	static func makeBottomSheetModel() -> SocialSupportBottomSheetModel {
		let commonBlockMock = ButtonsSection(title: nil,
											 socSupportButtons: [TestData.socialSupportButtonMock])

		let otherSectionMock = ButtonsSection(title: "Транспортные льготы",
											  socSupportButtons: [TestData.socialSupportButtonMock])

		let bottomSheetMock = SocialSupportBottomSheetModel(
			title: "Соцподдержка",
			eventForAnalytic: "socialSupport",
			commonBlock: commonBlockMock,
			transportBenefits: otherSectionMock,
			reabilitation: otherSectionMock,
			monthlyPayment: otherSectionMock,
			calculateSocialSupport: TestData.calculateSocialSupportMock
		)
		return bottomSheetMock
	}

	private enum TestData {
		static let socialSupportButtonMock = SocialSupportButton(
			title: "Набор льгот за одно заявление",
			icon: nil,
			url: "services_for_people_with_disabilities.URL",
			eventForAnalytic: "benefitsForOneStatementButton")

		static let calculateSocialSupportMock = CalculateSocialSupport(
			title: "Рассчитать социальные выплаты",
			description: "Еще больше выплат, включая соцвыплаты, зависящие от региона",
			buttonTitle: "Рассчитать",
			icon: nil,
			url: "soc_calculator.URL",
			eventForAnalytic: "socialCalcButton")
	}
}
