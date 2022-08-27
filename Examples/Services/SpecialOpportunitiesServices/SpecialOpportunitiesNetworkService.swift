//
//  SpecialOpportunitiesNetworkService.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.

typealias SocialOpportunitiesResult = (Result<SpecialOpportunitiesResponseModel, NetworkServiceError>) -> Void

/// Протокол сервиса предоставляющего данные для экрана Специальные возможности и шторки Соцподдержка
protocol SocialOpportunitiesNetworkServiceProtocol: AnyObject {
	/// Загрузить данные
	/// - Parameter completion: Результат загрузки
	func loadSpecialOpportunities(completion: @escaping SocialOpportunitiesResult)
}

/// Сервис запроса в сеть для получения данных
final class SocialOpportunitiesNetworkService {
	/// Тип используемого чейна
	var chainClass: UfsChainable.Type = UfsChain.self
	/// Путь запроса
	var path: String = "путь"

	private var currentChain: Chainable?

	private func process(chain: UfsChainable) -> SpecialOpportunitiesResponseModel? {
		if chain.error != nil {
			return nil
		}

		guard let data = chain.response as? Data else {
			return nil
		}

		do {
			let response = try JSONDecoder().decode(SpecialOpportunitiesResponseModel.self, from: data)
			return response
		} catch {
			return nil
		}
	}
}

// MARK: - SocialOpportunitiesNetworkServiceProtocol
extension SocialOpportunitiesNetworkService: SocialOpportunitiesNetworkServiceProtocol {

	func loadSpecialOpportunities(completion: @escaping SocialOpportunitiesResult) {
		do {
			try chainClass.performStart { chain in
				guard let chain = chain as? UfsChainable else { return }
				self.currentChain = chain

				chain.path = self.path

				chain.resultBlock = { [weak self] chain, _ in
					guard let self = self, let chain = chain as? UfsChainable else { return }
					self.currentChain = nil
					guard let model = self.process(chain: chain) else {
						completion(.failure(.noData))
						return
					}
					completion(.success(model))
				}
			}
		} catch {
			completion(.failure(.noData))
		}
	}
}
