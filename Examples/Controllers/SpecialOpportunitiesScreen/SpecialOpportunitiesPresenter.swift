//
//  SpecialOpportunitiesPresenter.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.

import DesignSystem
import SBFoundation

/// Презентер экрана Специальные возможности
final class SpecialOpportunitiesPresenter {
	private weak var view: SpecialOpportunitiesViewProtocol?
	private let interactor: SpecialOpportunitiesInteractorProtocol
	private let router: SpecialOpportunitiesRouterProtocol
	private let contentBuilder: SpecialOpportunitiesContentBuilderProtocol

	/// Данные для шторки Соцподдержка и имя экрана для аналитики
	private var bottomSheetModel: SocialSupportBottomSheetModel?
	private var screenAnalyticName = ""

	private enum Constants {
		static let pushBottomSheetTypeURL = "socSupport"
		static let alertButtonClickEvent = "SpecialOpportunitiesErrorAlertButton Click"
		static let alertShowedEvent = "SpecialOpportunitiesErrorAlert Show"
	}

	/// - Инициализатор презентера
	/// - Parameters:
	///   - view: вью модуля
	///   - interactor: интерактор модуля
	///   - router: роутер модуля
	init(view: SpecialOpportunitiesViewProtocol,
		 interactor: SpecialOpportunitiesInteractorProtocol,
		 router: SpecialOpportunitiesRouterProtocol,
		 contentBuilder: SpecialOpportunitiesContentBuilderProtocol) {
		self.view = view
		self.interactor = interactor
		self.router = router
		self.contentBuilder = contentBuilder
	}

	// MARK: - Private functions
	private func showSocialSupportBottomSheet(with model: SocialSupportBottomSheetModel?) {
		guard let model = model else { return }
		interactor.sendAnalytic(event: screenAnalyticName + " " + model.eventForAnalytic + " Show")
		let socSupportVC = SocSupportScreenAssembly().module(screenModel: model)
		router.presentViewController(socSupportVC)
	}

	private func fetchDataFailed() {
		interactor.sendAnalytic(event: Constants.alertShowedEvent)
		router.presentErrorAlertController(contentBuilder.makeErrorAlert())
	}
}

// MARK: - SpecialOpportunitiesPresenterProtocol
extension SpecialOpportunitiesPresenter: SpecialOpportunitiesPresenterProtocol {
	func didLoadView() {
		interactor.fetchData { [weak self] model in
			guard let self = self, let model = model else {
				self?.fetchDataFailed()
				return
			}
			// Данные для шторки и аналитики
			self.bottomSheetModel = model.socialSupportBottomSheet
			self.screenAnalyticName = model.header.eventForAnalytic
			// Формирование айтемов
			var items: [DSNFormItemDelegate] = []
			items = self.contentBuilder.makeItemsFrom(model: model)

			self.interactor.sendAnalytic(event: self.screenAnalyticName + " Show")
			self.view?.show(items: items)
		}
	}
}

// MARK: - SpecialOpportunitiesContentBuilderDelegate
extension SpecialOpportunitiesPresenter: SpecialOpportunitiesContentBuilderDelegate {
	func itemTapped(_ type: String?, _ url: String?, _ eventForAnalytic: String) {
		interactor.sendAnalytic(event: screenAnalyticName + " " + eventForAnalytic + " Click")
		// пушим шторку Соцподдержки
		if let type = type, type == Constants.pushBottomSheetTypeURL {
			showSocialSupportBottomSheet(with: bottomSheetModel)
		// открываем функционал по диплинку
		} else if let url = url, !url.isEmpty {
			router.open(urlPath: url)
		}
	}

	func errorAlertCloseButtonTapped() {
		interactor.sendAnalytic(event: Constants.alertButtonClickEvent)
		router.dismissPresentedController(shouldToPop: true)
	}
}
