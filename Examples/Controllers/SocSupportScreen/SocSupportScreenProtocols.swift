//
//  SocSupportScreenProtocols.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 28.07.2022.
// 
//

import DesignSystem

/// Протокол сборщика модуля
protocol SocSupportScreenAssemblyProtocol: AnyObject {
	/// Собрать viper модуль
	/// - Patameter: screenModel модель данных
	/// - Returns: view модуля
	func module(screenModel: SocialSupportBottomSheetModel) -> UIViewController
}

/// Протокол вью
protocol SocSupportScreenViewProtocol: AnyObject {
	/// Отобразить данные
	/// - Parameter items: итемы данных
	func show(items: [DSNFormItemDelegate])
}

/// Протокол презентера
protocol SocSupportScreenPresenterProtocol: AnyObject {
	/// Метод вызывается при загрузке View
	func didLoadView()
}

/// Протокол интерактора
protocol SocSupportScreenInteractorProtocol: AnyObject {
	/// Запрос получения данных
	/// - Returns: модель для отрисовки айтемов
	func returnModel() -> SocialSupportBottomSheetModel
	/// Функция отправки аналитики
	/// - Parameter event: параметр аналитики
	func sendAnalytic(event: String)
	/// Получить параметр из лончера
	/// - Parameter key: параметр аналитики
	/// - Returns: значение параметра из лончера
	func getValueLauncher(key: String?) -> String?
}

/// Протокол роутера
protocol SocSupportScreenRouterProtocol: AnyObject {
	/// Открывает данный urlPath(диплинк или внешний URL)
	/// - Parameter urlPath: Диплинк или внешний URL
	func open(urlPath: String?)
}
