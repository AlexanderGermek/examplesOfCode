//
//  SocSupportScreenRouter.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 28.07.2022.
// 
//
import SBFoundation
import SafariServices

/// Роутер экрана Соцподдержка
final class SocSupportScreenRouter {
	private weak var navigationController: UINavigationController?
	private let appRouter: SBFTransitionRouterProtocol?

	/// - Инициализатор роутера
	/// - Parameters:
	///   - appRouter: Роутер приложения
	///   - navigationController: Текущий навигационный контроллер
	init(appRouter: SBFTransitionRouterProtocol? = SBFApp.shared()?.router,
		 navigationController: UINavigationController? = UINavigationController.upperNavController()) {
		self.appRouter = appRouter
		self.navigationController = navigationController
	}

	// MARK: - Private functions
	private func canOpenDeeplink(urlPath: String?) -> Bool {
		guard let urlPath = urlPath else { return false }
		return appRouter?.isDeeplinkAvailable(urlPath) ?? false
	}

	private func showInSafariViewController(forUrlPath urlPath: String) {
		guard let url = URL(string: urlPath) else { return }
		let safariViewController = SFSafariViewController(url: url)
		navigationController?.dismiss(animated: true, completion: { [weak self] in
			self?.navigationController?.present(safariViewController, animated: true)
		})
	}
}

// MARK: - SocSupportScreenRouterProtocol
extension SocSupportScreenRouter: SocSupportScreenRouterProtocol {
	func open(urlPath: String?) {
		guard let appRouter = appRouter, let urlPath = urlPath, !urlPath.isEmpty else { return }

		if canOpenDeeplink(urlPath: urlPath) {
			appRouter.prepareTransition(forURLPath: "openitsolutionsonline://" + urlPath,
										transitionInfo: nil,
										performTransitionAsReady: true)
		} else if appRouter.isURLPathAvailable(urlPath) {
			showInSafariViewController(forUrlPath: urlPath)
		}
	}
}
