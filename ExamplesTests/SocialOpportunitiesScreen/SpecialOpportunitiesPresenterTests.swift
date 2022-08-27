//
//  SpecialOpportunitiesPresenterTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 25.07.2022.
// 
//

import XCTest
@testable import PayrollCard

final class SpecialOpportunitiesPresenterTests: XCTestCase {

	private var viewMock: SpecialOpportunitiesViewMock!
	private var interactorMock: SpecialOpportunitiesInteractorMock!
	private var routerMock: SpecialOpportunitiesRouterMock!
	private var analyticsSpy: AnalyticsSpy!
	private var contentBuilder: SpecialOpportunitiesContentBuilderMock!
	private var networkServiceMock: SocialOpportunitiesNetworkServiceMock!
	private var sut: SpecialOpportunitiesPresenter!
	private var navigationController: NavigationControllerMock!

	// MARK: - Setup
	override func setUp() {
		super.setUp()
		viewMock = SpecialOpportunitiesViewMock()
		analyticsSpy = AnalyticsSpy()
		contentBuilder = SpecialOpportunitiesContentBuilderMock()
		networkServiceMock = SocialOpportunitiesNetworkServiceMock()
		interactorMock = SpecialOpportunitiesInteractorMock(
			analytics: analyticsSpy,
			networkService: networkServiceMock
		)
		navigationController = NavigationControllerMock()
		routerMock = SpecialOpportunitiesRouterMock(view: viewMock, navigationController: navigationController)
		sut = SpecialOpportunitiesPresenter(view: viewMock,
												  interactor: interactorMock,
												  router: routerMock,
												  contentBuilder: contentBuilder)
		contentBuilder.delegate = sut
		viewMock.presenter = sut
	}

	override func tearDown() {
		viewMock = nil
		analyticsSpy = nil
		contentBuilder = nil
		navigationController = nil
		networkServiceMock = nil
		interactorMock = nil
		sut = nil
		routerMock = nil
		super.tearDown()
	}

	// MARK: - Tests
	func testThatRequestWasFail() {
		// arrange
		networkServiceMock.loadedError = true
		let analyticsError = "SpecialOpportunitiesErrorAlert Show"
		var isStopLoaderCalled = false
		var isPresentViewControllerCalled = false
		viewMock.stopLoaderStub = {
			isStopLoaderCalled = true
		}
		contentBuilder.makeErrorAlertStub = {
			return RichAlertViewController(image: UIImage(),
										   title: "",
										   subtitle: "",
										   buttons: [])
		}
		routerMock.presentErrorAlertControllerStub = { viewController in
			isPresentViewControllerCalled = viewController is RichAlertViewController
		}

		// act
		sut.didLoadView()

		// assert
		XCTAssertTrue(networkServiceMock.loadExecuted)
		XCTAssertTrue(isStopLoaderCalled)
		XCTAssertTrue(isPresentViewControllerCalled)
		XCTAssertTrue(analyticsSpy.eventNames.contains(analyticsError))
	}

	func testThatRequestWasSuccess() {
		// arrange
		networkServiceMock.loadedError = false
		let analyticsSuccess = "specialOpportunities Show"

		var isShowCalled = false
		viewMock.showStub = { items in
			guard let headerItem = items.first as? SectionHeaderFormItem else { return }
			isShowCalled = headerItem.title == "Специальные возможности"
			&& headerItem.subtitle == "Для людей с инвалидностью"
		}

		contentBuilder.makeItemsFromStub = { model in
			[SectionHeaderFormItem(title: model.header.title, subtitle: model.header.subtitle)]
		}

		// act
		sut.didLoadView()

		// assert
		XCTAssertTrue(networkServiceMock.loadExecuted)
		XCTAssertTrue(isShowCalled)
		XCTAssertTrue(analyticsSpy.eventNames.contains(analyticsSuccess))
	}

	// MARK: - SpecialOpportunitiesContentBuilderDelegate Tests
	func testThatRouterPushSocSupportController() {
		// arrange
		networkServiceMock.loadedError = false
		let type = "socSupport"
		let url = ""
		let eventForAnalytic = "test"
		var isPresentViewControllerCalled = false
		routerMock.presentViewControllerStub = { viewController in
			isPresentViewControllerCalled = viewController is SocSupportScreenView
		}

		// act
		sut.didLoadView()
		sut.itemTapped(type, url, eventForAnalytic)

		// assert
		XCTAssertTrue(analyticsSpy.eventNames.contains("specialOpportunities \(eventForAnalytic) Click"))
		XCTAssertTrue(analyticsSpy.eventNames.contains("specialOpportunities socialSupport Show"))
		XCTAssertTrue(isPresentViewControllerCalled)
	}

	func testThatRouterOpenDeeplink() {
		// arrange
		networkServiceMock.loadedError = false
		let type = "deeplink"
		let testUrl = "testURL"
		let eventForAnalytic = "test"
		var isOpenCalled = false
		routerMock.openStub = { url in
			isOpenCalled = testUrl == url
		}

		// act
		sut.didLoadView()
		sut.itemTapped(type, testUrl, eventForAnalytic)

		// assert
		XCTAssertTrue(analyticsSpy.eventNames.contains("specialOpportunities \(eventForAnalytic) Click"))
		XCTAssertTrue(isOpenCalled)
	}

	func testThatErrorAlertCloseButtonTapped() {
		// arrange
		var isDismissCalled = false
		routerMock.dismissPresentedControllerStub = { shouldToPop in
			isDismissCalled = shouldToPop
		}

		// act
		sut.errorAlertCloseButtonTapped()

		// assert
		XCTAssertTrue(analyticsSpy.eventNames.contains("SpecialOpportunitiesErrorAlertButton Click"))
		XCTAssertTrue(isDismissCalled)
	}
}
