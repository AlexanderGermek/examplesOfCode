//
//  SocSupportScreenInteractorSpy.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

@testable import PayrollCard

final class SocSupportScreenInteractorSpy {
	var sendAnalyticStub: ((String) -> Void)?
	var getValueLauncherStub: ((String?) -> String?)?
}

// MARK: - SocSupportScreenInteractorProtocol
extension SocSupportScreenInteractorSpy: SocSupportScreenInteractorProtocol {
	func returnModel() -> SocialSupportBottomSheetModel {
		return SocSupportScreenInteractorTests.makeBottomSheetModel()
	}

	func sendAnalytic(event: String) {
		sendAnalyticStub?(event)
	}

	func getValueLauncher(key: String?) -> String? {
		getValueLauncherStub?(key)
	}
}
