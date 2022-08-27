//
//  SocSupportScreenAssembly.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 28.07.2022.
// 
//
import DesignSystem

/// Сборщик экрана
final class SocSupportScreenAssembly: SocSupportScreenAssemblyProtocol {
	// MARK: - SocSupportScreenAssemblyProtocol
	/// Собрать модуль
	/// - Parameter screenModel: модель шторки
	/// - Returns view модуля
	func module(screenModel: SocialSupportBottomSheetModel) -> UIViewController {
		let view = SocSupportScreenView()
		view.modalPresentationStyle = .custom
		view.transitioningDelegate = BottomSheetModalTransitioningDelegate.default

		let analytics = Analytics()
		let contentBuilder = SocSupportScreenContentBuilder()
		let launcher = UFSLauncherDecoder()

		let interactor = SocSupportScreenInteractor(analytics: analytics,
													model: screenModel,
													launcher: launcher)

		let router = SocSupportScreenRouter()

		let presenter = SocSupportScreenPresenter(
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
