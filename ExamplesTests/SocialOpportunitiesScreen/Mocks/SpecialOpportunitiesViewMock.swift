//
//  SpecialOpportunitiesViewMock.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 25.07.2022.
// 
//

@testable import PayrollCard

final class SpecialOpportunitiesViewMock: UIViewController {
	var presenter: SpecialOpportunitiesPresenterProtocol?
	var showStub: (([DSNFormItemDelegate]) -> Void)?
	var stopLoaderStub: (() -> Void)?
}

// MARK: - SpecialOpportunitiesViewProtocol
extension SpecialOpportunitiesViewMock: SpecialOpportunitiesViewProtocol {
	func show(items: [DSNFormItemDelegate]) {
		showStub?(items)
	}

	func stopLoader() {
		stopLoaderStub?()
	}
}
