//
//  SocSupportScreenPresenter.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 28.07.2022.
// 
//

/// Презентер экрана Соцподдержка
final class SocSupportScreenPresenter {
	private weak var view: SocSupportScreenViewProtocol?
	private let interactor: SocSupportScreenInteractorProtocol
	private let router: SocSupportScreenRouterProtocol
	private let contentBuilder: SocSupportScreenContentBuilderProtocol

	/// - Инициализатор презентера
	/// - Parameters:
	///   - view: вью модуля
	///   - interactor: интерактор модуля
	///   - router: роутер модуля
	///   - contentBuilder: провайдер данных
	init(view: SocSupportScreenViewProtocol,
		 interactor: SocSupportScreenInteractorProtocol,
		 router: SocSupportScreenRouterProtocol,
		 contentBuilder: SocSupportScreenContentBuilderProtocol) {
		self.view = view
		self.interactor = interactor
		self.router = router
		self.contentBuilder = contentBuilder
	}
}

// MARK: - SocSupportScreenPresenterProtocol
extension SocSupportScreenPresenter: SocSupportScreenPresenterProtocol {
	func didLoadView() {
		let formItems = contentBuilder.makeItems(model: interactor.returnModel())
		view?.show(items: formItems)
	}
}

// MARK: - SocSupportScreenContentBuilderDelegate
extension SocSupportScreenPresenter: SocSupportScreenContentBuilderDelegate {
	func itemTapped(_ url: String?, _ eventForAnalytic: String) {
		interactor.sendAnalytic(event: eventForAnalytic)
		guard let urlString = interactor.getValueLauncher(key: url), !urlString.isEmpty else {
			return
		}
		router.open(urlPath: url)
	}
}
