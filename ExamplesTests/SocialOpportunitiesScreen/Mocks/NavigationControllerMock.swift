//
//  NavigationControllerMock.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 26.07.2022.
// 
//

final class NavigationControllerMock: UINavigationController {
	var presentStub: ((UIViewController) -> Void)?
	var dismissStub: (() -> Void)?
	var popViewControllerStub: (() -> UIViewController?)?
	var dismissWithCompletionStub: (() -> Void)?

	override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
		presentStub?(viewControllerToPresent)
	}

	override func dismiss(animated flag: Bool) {
		dismissStub?()
	}

	override func popViewController(animated: Bool) -> UIViewController? {
		popViewControllerStub?()
	}

	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		dismissWithCompletionStub?()
	}
}
