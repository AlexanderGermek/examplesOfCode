//
//  SpecialOpportunitiesPresenterSpy.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 27.07.2022.
// 
//

final class SpecialOpportunitiesPresenterSpy {
	var itemTappedStub: (() -> Void)?
	var errorAlertCloseButtonTappedStub: (() -> Void)?
}

// MARK: - SpecialOpportunitiesContentBuilderDelegate
extension SpecialOpportunitiesPresenterSpy: SpecialOpportunitiesContentBuilderDelegate {
	func itemTapped(_ type: String?, _ url: String?, _ eventForAnalytic: String) {
		itemTappedStub?()
	}

	func errorAlertCloseButtonTapped() {
		errorAlertCloseButtonTappedStub?()
	}
}
