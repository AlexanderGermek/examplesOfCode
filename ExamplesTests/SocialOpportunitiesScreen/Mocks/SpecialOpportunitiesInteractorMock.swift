//
//  SpecialOpportunitiesInteractorMock.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 25.07.2022.
// 
//

@testable import PayrollCard

final class SpecialOpportunitiesInteractorMock {
	var analytics: AnalyticsProtocol
	var networkService: SocialOpportunitiesNetworkServiceProtocol
	private let categoryAnalytics: Analytics.Category = .social

	init(analytics: AnalyticsProtocol, networkService: SocialOpportunitiesNetworkServiceProtocol) {
		self.analytics = analytics
		self.networkService = networkService
	}
}

// MARK: - SpecialOpportunitiesInteractorProtocol
extension SpecialOpportunitiesInteractorMock: SpecialOpportunitiesInteractorProtocol {
	func fetchData(completion: @escaping (SpecialOpportunitiesBodyModel?) -> Void) {
		networkService.loadSpecialOpportunities { result in
			switch result {
			case .success(let model):
				completion(model.body)
			case .failure(_):
				completion(nil)
			}
		}
	}

	func sendAnalytic(event: String) {
		analytics.send(eventName: event, category: categoryAnalytics, with: [:])
	}
}
