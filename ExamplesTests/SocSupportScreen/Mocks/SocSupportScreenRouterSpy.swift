//
//  SocSupportScreenRouterSpy.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

@testable import PayrollCard

final class SocSupportScreenRouterSpy {
	var openStub: ((String?) -> Void)?
}

// MARK: - SocSupportScreenRouterProtocol
extension SocSupportScreenRouterSpy: SocSupportScreenRouterProtocol {
	func open(urlPath: String?) {
		openStub?(urlPath)
	}
}
