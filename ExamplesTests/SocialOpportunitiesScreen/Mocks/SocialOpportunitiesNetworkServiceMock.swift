//
//  SocialOpportunitiesNetworkServiceMock.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.
// 
//

// MARK: - SocialOpportunitiesNetworkServiceProtocol
extension SocialOpportunitiesNetworkServiceMock: SocialOpportunitiesNetworkServiceProtocol {

	func loadSpecialOpportunities(completion: @escaping SocialOpportunitiesResult) {

		loadExecuted = true

		if loadedError == false {
			completion(.success(makeModelMock()))
		} else {
			completion(.failure(.noData))
		}
	}
}

/// Мок-объект для сервиса запроса данных экрана Спец возможности
final class SocialOpportunitiesNetworkServiceMock {
	var loadedError = false
	var loadExecuted = false

	private func makeModelMock() -> SpecialOpportunitiesResponseModel {

		let commonBlockMock = ButtonsSection(title: nil,
											 socSupportButtons: [TestData.socialSupportButtonMock])

		let otherSectionMock = ButtonsSection(title: "Транспортные льготы",
											  socSupportButtons: [TestData.socialSupportButtonMock])

		let bottomSheetMock = SocialSupportBottomSheetModel(
			title: "Соцподдержка",
			eventForAnalytic: "socialSupport",
			commonBlock: commonBlockMock,
			transportBenefits: otherSectionMock,
			reabilitation: otherSectionMock,
			monthlyPayment: otherSectionMock,
			calculateSocialSupport: TestData.calculateSocialSupportMock
		)

		let bodyMock = SpecialOpportunitiesBodyModel(
			header: TestData.headerMock,
			serviceButtons: TestData.serviceButtonsMock,
			socialSupportBottomSheet: bottomSheetMock
		)

		let response = SpecialOpportunitiesResponseModel(success: true, body: bodyMock)
		return response
	}
}

// MARK: - TestData
extension SocialOpportunitiesNetworkServiceMock {
	enum TestData {
		static let headerMock = SpecialOpportunitiesHeaderModel(title: "Специальные возможности",
																subtitle: "Для людей с инвалидностью",
																eventForAnalytic: "specialOpportunities")
		static let serviceButtonsMock = [
			SocialSupportServiceButton(
				title: "Специальное обслуживание",
				subtitle: "Сообщите, если вам нужен сурдоперевод в офисе или пандус",
				icon: "ds_ic_36_man_wheelchair",
				url: "",
				eventForAnalytic: "specialService",
				type: "deeplink"),

			SocialSupportServiceButton(
				title: "Специальное обслуживание",
				subtitle: "Продукты и сервисы СБерБанка для людей с инвалидностью",
				icon: "ds_ic_36_building",
				url: "",
				eventForAnalytic: "specialService",
				type: "deeplink")
		]

		static let socialSupportButtonMock = SocialSupportButton(
			title: "Набор льгот за одно заявление",
			icon: nil,
			url: "services_for_people_with_disabilities.URL",
			eventForAnalytic: "benefitsForOneStatementButton")

		static let calculateSocialSupportMock = CalculateSocialSupport(
			title: "Рассчитать социальные выплаты",
			description: "Еще больше выплат, включая соцвыплаты, зависящие от региона",
			buttonTitle: "Рассчитать",
			icon: nil,
			url: "soc_calculator.URL",
			eventForAnalytic: "socialCalcButton")
	}
}
