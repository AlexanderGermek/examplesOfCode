//
//  SpecialOpportunitiesProtocols.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.

import DesignSystem

/// Протокол сборщика модуля
protocol SpecialOpportunitiesAssemblyProtocol: AnyObject {
	/// Собрать viper модуль
	/// - Returns: view модуля
	func module() -> UIViewController
}

/// Протокол вью
protocol SpecialOpportunitiesViewProtocol: AnyObject {
	/// Отобразить данные
	/// - Parameter items: итемы данных
	func show(items: [DSNFormItemDelegate])
	/// Остановить индикатор загрузки
	func stopLoader()
}

/// Протокол презентера
protocol SpecialOpportunitiesPresenterProtocol: AnyObject {
	/// Метод вызывается при загрузке View
	func didLoadView()
}

/// Протокол интерактора
protocol SpecialOpportunitiesInteractorProtocol: AnyObject {
	/// Запрос получения данных
	/// - Parameter completion: body-модель данных
	func fetchData(completion: @escaping (SpecialOpportunitiesBodyModel?) -> Void)
	/// Функция отправки аналитики
	/// - Parameter event: параметр аналитики
	func sendAnalytic(event: String)
}

/// Протокол роутера
protocol SpecialOpportunitiesRouterProtocol: AnyObject {
	/// Открывает данный urlPath(диплинк или внешний URL)
	/// - Parameter urlPath: Диплинк или внешний URL
	func open(urlPath: String?)
	/// Презентует алерт контроллер с ошибкой
	/// - Parameter viewController: контроллер, который нужно презентовать
	func presentErrorAlertController(_ viewController: UIViewController)
	/// Закрыть контроллер, презентованный в данный момент
	/// - Parameter shouldToPop: флаг, нужно ли возвращаться на предыдущий контроллер в стеке
	func dismissPresentedController(shouldToPop: Bool)
	/// Презентует контроллер
	/// - Parameter viewController: контроллер, который нужно презентовать
	func presentViewController(_ viewController: UIViewController)
}
