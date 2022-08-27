//
//  SpecialOpportunitiesContentBuilderMock.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 27.07.2022.
// 
//

import DesignSystem

final class SpecialOpportunitiesContentBuilderMock {
	var delegate: SpecialOpportunitiesContentBuilderDelegate?
	var makeItemsFromStub: ((SpecialOpportunitiesBodyModel) -> [DSNFormItemDelegate])?
	var makeErrorAlertStub: (() -> UIViewController)?
}

// MARK: - SpecialOpportunitiesContentBuilderProtocol
extension SpecialOpportunitiesContentBuilderMock: SpecialOpportunitiesContentBuilderProtocol {

	func makeItemsFrom(model: SpecialOpportunitiesBodyModel) -> [DSNFormItemDelegate] {
		makeItemsFromStub?(model) ?? []
	}

	func makeErrorAlert() -> UIViewController {
		makeErrorAlertStub?() ?? UIViewController()
	}
}
