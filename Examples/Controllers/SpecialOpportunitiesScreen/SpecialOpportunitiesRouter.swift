//
//  SpecialOpportunitiesRouter.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.

import SBFoundation
import SafariServices

/// Роутер экрана Специальные возможности
final class SpecialOpportunitiesRouter {
	/// Вью модуля
	weak var view: SpecialOpportunitiesViewProtocol?

	private let router: SBFTransitionRouterProtocol?
	private weak var navigationController: UINavigationController?

	/// Инициализатор роутера
	/// - Parameters:
	///   - view: Вью модуля
	///   - router: Роутер приложения
	///   - navigationController: Текущий навигационный контроллер
	init(view: SpecialOpportunitiesViewProtocol,
		 router: SBFTransitionRouterProtocol? = SBFApp.shared()?.router,
		 navigationController: UINavigationController? = UINavigationController.upperNavController()) {
		self.view = view
		self.router = router
		self.navigationController = navigationController
	}

	// MARK: - Private functions
	private func canOpen(urlPath: String?) -> Bool {
		guard let urlPath = urlPath else { return false }
		return router?.isDeeplinkAvailable(urlPath) ?? false
	}
}

// MARK: - SpecialOpportunitiesRouterProtocol
extension SpecialOpportunitiesRouter: SpecialOpportunitiesRouterProtocol {
	func open(urlPath: String?) {
		guard let router = router,
			  let urlPath = urlPath,
			  !urlPath.isEmpty,
			  canOpen(urlPath: urlPath)
		else { return }

		router.prepareTransition(forURLPath: "openitsolutionsonline://" + urlPath,
								 transitionInfo: nil,
								 performTransitionAsReady: true)
	}

	func presentErrorAlertController(_ viewController: UIViewController) {
		view?.stopLoader()
		navigationController?.present(viewController, animated: true)
	}

	func dismissPresentedController(shouldToPop: Bool) {
		navigationController?.dismiss(animated: UIView.areAnimationsEnabled)
		if shouldToPop {
			navigationController?.popViewController(animated: UIView.areAnimationsEnabled)
		}
	}

	func presentViewController(_ viewController: UIViewController) {
		navigationController?.present(viewController, animated: true)
	}
}
