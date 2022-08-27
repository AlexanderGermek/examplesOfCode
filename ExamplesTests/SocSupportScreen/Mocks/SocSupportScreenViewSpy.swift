//
//  SocSupportScreenViewSpy.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

@testable import PayrollCard

final class SocSupportScreenViewSpy: UIViewController {
	var showStub: (() -> Void)?
}

// MARK: - SpecialOpportunitiesViewProtocol
extension SocSupportScreenViewSpy: SocSupportScreenViewProtocol {
	func show(items: [DSNFormItemDelegate]) {
		showStub?()
	}
}
