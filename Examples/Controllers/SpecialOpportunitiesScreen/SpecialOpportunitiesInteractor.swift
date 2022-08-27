//
//  SpecialOpportunitiesInteractor.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.

/// Интерактор экрана Спец возможности
final class SpecialOpportunitiesInteractor {
	private let analytics: AnalyticsProtocol
	private let networkService: SocialOpportunitiesNetworkServiceProtocol
	private let categoryAnalytics: Analytics.Category = .social

	/// - Инициализатор интерактора
	/// - Parameters:
	///   - analytics: сервис отправки эвентов
	///   - networkService: сервис для запросов данных в сеть
	init(analytics: AnalyticsProtocol, networkService: SocialOpportunitiesNetworkServiceProtocol) {
		self.analytics = analytics
		self.networkService = networkService
	}
}

// MARK: - SpecialOpportunitiesInteractorProtocol
extension SpecialOpportunitiesInteractor: SpecialOpportunitiesInteractorProtocol {

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
