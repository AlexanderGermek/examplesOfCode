//
//  SpecialOpportunitiesRouterMock.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 25.07.2022.
// 
//

@testable import PayrollCard

final class SpecialOpportunitiesRouterMock {
	private var view: SpecialOpportunitiesViewProtocol
	private var navigationController: NavigationControllerMock

	var openStub: ((String?) -> Void)?
	var presentErrorAlertControllerStub: ((UIViewController) -> Void)?
	var dismissPresentedControllerStub: ((Bool) -> Void)?
	var presentViewControllerStub: ((UIViewController) -> Void)?

	init(view: SpecialOpportunitiesViewProtocol, navigationController: NavigationControllerMock) {
		self.view = view
		self.navigationController = navigationController
	}
}

// MARK: - SpecialOpportunitiesRouterProtocol
extension SpecialOpportunitiesRouterMock: SpecialOpportunitiesRouterProtocol {
	func open(urlPath: String?) {
		openStub?(urlPath)
	}

	func presentErrorAlertController(_ viewController: UIViewController) {
		view.stopLoader()
		presentErrorAlertControllerStub?(viewController)
	}

	func dismissPresentedController(shouldToPop: Bool) {
		dismissPresentedControllerStub?(shouldToPop)
	}

	func presentViewController(_ viewController: UIViewController) {
		presentViewControllerStub?(viewController)
	}
}
