//
//  SocSupportScreenContentBuilderSpy.swift
//  PayrollCardTests
//
//  Created by Гермек Александр Георгиевич on 29.07.2022.
// 
//

@testable import PayrollCard

final class SocSupportScreenContentBuilderSpy {
	var delegate: SocSupportScreenContentBuilderDelegate?
}

// MARK: - SocSupportScreenContentBuilderProtocol
extension SocSupportScreenContentBuilderSpy: SocSupportScreenContentBuilderProtocol {
	func makeItems(model: SocialSupportBottomSheetModel) -> [DSNFormItemDelegate] {
		return []
	}
}
