//
//  SocSupportScreenInteractor.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 28.07.2022.
// 
//

/// Интерактор экрана Соцподдержка
final class SocSupportScreenInteractor {
	private var analytics: AnalyticsProtocol
	private var model: SocialSupportBottomSheetModel
	private let launcher: UFSLauncherDecoderProtocol
	private let categoryAnalytics: Analytics.Category = .social

	/// - Инициализатор интерактора
	/// - Parameters:
	///   - analytics: сервис отправки эвентов
	///   - model: модель данных для отображения
	///   - launcher: лончер для получения параметров
	init(analytics: AnalyticsProtocol,
		 model: SocialSupportBottomSheetModel,
		 launcher: UFSLauncherDecoderProtocol) {
		self.analytics = analytics
		self.model = model
		self.launcher = launcher
	}
}

// MARK: - SocSupportScreenInteractorProtocol
extension SocSupportScreenInteractor: SocSupportScreenInteractorProtocol {
	func returnModel() -> SocialSupportBottomSheetModel {
		return model
	}

	func sendAnalytic(event: String) {
		analytics.send(eventName: event, category: categoryAnalytics, with: [:])
	}

	func getValueLauncher(key: String?) -> String? {
		guard let key = key else { return nil }
		let account: PersonalAccountSettings.AccountType = .social
		let moduleName = account.launcherModuleName
		return launcher.getValueFromOptions(moduleName: moduleName, key: key)
	}
}
