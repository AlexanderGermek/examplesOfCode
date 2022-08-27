//
//  SocSupportScreenPresenterSpy.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

@testable import PayrollCard

final class SocSupportScreenPresenterSpy {
	var itemTappedStub: (() -> Void)?
	var delegate: SocSupportScreenContentBuilderDelegate?
}

// MARK: - SocSupportScreenContentBuilderDelegate
extension SocSupportScreenPresenterSpy: SocSupportScreenContentBuilderDelegate {
	func itemTapped(_ url: String?, _ eventForAnalytic: String) {
		itemTappedStub?()
	}
}
