//
//  SpecialOpportunitiesAssembly.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.

/// Сборщик экрана Специальные возможности
final class SpecialOpportunitiesAssembly: SpecialOpportunitiesAssemblyProtocol {

	// MARK: - SpecialOpportunitiesAssemblyProtocol

	/// Собрать модуль
	/// - Returns view модуля
	func module() -> UIViewController {
		let view = SpecialOpportunitiesView()

		let analytics = Analytics()
		let networkService = SocialOpportunitiesNetworkService()
		let contentBuilder = SpecialOpportunitiesContentBuilder()
		let interactor = SpecialOpportunitiesInteractor(analytics: analytics,
														networkService: networkService)

		let router = SpecialOpportunitiesRouter(view: view)

		let presenter = SpecialOpportunitiesPresenter(
			view: view,
			interactor: interactor,
			router: router,
			contentBuilder: contentBuilder
		)

		contentBuilder.delegate = presenter
		view.presenter = presenter
		return view
	}
}
