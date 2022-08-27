//
//  SocialOpportunitiesNetworkServiceTests.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.
// 
//

import XCTest
@testable import PayrollCard

final class SocialOpportunitiesNetworkServiceTests: XCTestCase {

	private var networkService: SocialOpportunitiesNetworkService!
	private var chainMock: UfsChainMock!

	override func setUp() {
		super.setUp()
		chainMock = UfsChainMock()
		UfsChainMock.stubbedInstance = chainMock
		networkService = SocialOpportunitiesNetworkService()
		networkService.chainClass = UfsChainMock.self
	}

	override func tearDown() {
		chainMock = nil
		networkService = nil
		super.tearDown()
	}

	func testFetchingWithNoDataError() {
		// arrange
		chainMock.error = NetworkServiceError.noData

		// act
		var theResult: Result<SpecialOpportunitiesResponseModel, NetworkServiceError>?
		networkService.loadSpecialOpportunities { result in
			theResult = result
		}

		// assert
		XCTAssertFalse(chainMock.switchOffMessagesAndAlerts)
		guard case .failure(let error) = theResult, error == .noData else {
			XCTFail("Error!")
			return
		}
	}

	func testFetchingWithSuccessTrue() {
		// arrange
		networkService.path = "/test"
		let data = Data("{\"success\": true}".utf8)
		chainMock.response = data

		// act
		var theResult: Result<SpecialOpportunitiesResponseModel, NetworkServiceError>?
		networkService.loadSpecialOpportunities { result in
			theResult = result
		}

		// assert
		XCTAssertFalse(chainMock.switchOffMessagesAndAlerts)
		guard case .success(let result) = theResult else {
			XCTFail("Error!")
			return
		}
		XCTAssertTrue(result.success)
	}

	func testFetchingWithSuccessFalse() {
		// arrange
		networkService.path = "/test"
		let data = Data("{\"success\": false}".utf8)
		chainMock.response = data

		// act
		var theResult: Result<SpecialOpportunitiesResponseModel, NetworkServiceError>?
		networkService.loadSpecialOpportunities { result in
			theResult = result
		}

		// assert
		XCTAssertFalse(chainMock.switchOffMessagesAndAlerts)
		guard case .success(let result) = theResult else {
			XCTFail("Error!")
			return
		}
		XCTAssertFalse(result.success)
	}
}
