//
//  SocSupportScreenContentBuilder.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 28.07.2022.
// 
//
import DesignSystem

/// Протокол провайдера экрана Соцподдержка
protocol SocSupportScreenContentBuilderProtocol: AnyObject {
	/// Обработчик событий по тапу на ячейку
	var delegate: SocSupportScreenContentBuilderDelegate? { get set }
	/// Функция получения айтемов для FormView
	/// - Parameter model: body модели запроса
	/// - Returns: массив айтемов
	func makeItems(model: SocialSupportBottomSheetModel) -> [DSNFormItemDelegate]
}

/// Протокол обработчика событий провайдера
protocol SocSupportScreenContentBuilderDelegate: AnyObject {
	/// Обработка нажатия на айтем или хинт баннер
	/// - Parameters:
	///   - url: диплинк или ссылка на внешний сайт
	///   - eventForAnalytic: событие аналитики для нажатия
	func itemTapped(_ url: String?, _ eventForAnalytic: String)
}

/// Поставщик контента для экрана Соцподдержка
final class SocSupportScreenContentBuilder {
	/// Обработчик событий по тапу на ячейку
	weak var delegate: SocSupportScreenContentBuilderDelegate?

	// MARK: - Private functions
	private func createHeaderItem(title: String) -> DSNFormItemDelegate {
		SectionHeaderFormItem(title: title)
	}

	private func createSocSupportBlock(data: ButtonsSection) -> [DSNFormItemDelegate] {
		createBlock(data: data.socSupportButtons)
	}

	private func createBlockWithSubheader(data: ButtonsSection) -> [DSNFormItemDelegate] {
		let subheaderItem = DSNSectionSubheaderFormItem(title: data.title)
		return [subheaderItem] + createBlock(data: data.socSupportButtons)
	}

	private func createBlock(data: [SocialSupportButton]) -> [DSNFormItemDelegate] {
		return data.compactMap { model in
			let disclosureItem = DSNDisclosureCellFormItem(title: model.title)
			disclosureItem.iconName = IconsMapper().semanticImage(semanticName: model.icon)?.objcName
			disclosureItem.iconSettings = .default
			disclosureItem.actionBlock = { [weak delegate] in
				delegate?.itemTapped(model.url, model.eventForAnalytic)
			}
			return disclosureItem
		}
	}

	private func createCalculateSocialSupportHintBanner(data: CalculateSocialSupport) -> DSNFormItemDelegate {
		let calculateButton = Action(title: data.buttonTitle) { [weak delegate] in
			delegate?.itemTapped(data.url, data.eventForAnalytic)
		}
		let icon = IconsMapper().semanticImage(semanticName: data.icon)?.image
		let hintBanner = HintBanner(style: .bodySuccess,
										title: data.title,
										subtitle: data.description,
										icon: icon,
										button: calculateButton,
										closeAction: nil)

		return hintBanner.makeItem()
	}
}

// MARK: - SocSupportScreenContentBuilderProtocol
extension SocSupportScreenContentBuilder: SocSupportScreenContentBuilderProtocol {
	func makeItems(model: SocialSupportBottomSheetModel) -> [DSNFormItemDelegate] {
		let headerItem = createHeaderItem(title: model.title)
		let socSupportBlock = createSocSupportBlock(data: model.commonBlock)
		let transportBenefitsBlock = createBlockWithSubheader(data: model.transportBenefits)
		let reabilitationBlock = createBlockWithSubheader(data: model.reabilitation)
		let monthlyPaymentBlock = createBlockWithSubheader(data: model.monthlyPayment)
		let hintBannerItem = createCalculateSocialSupportHintBanner(data: model.calculateSocialSupport)

		var items: [DSNFormItemDelegate] = []
		items.append(headerItem)
		items.append(contentsOf: socSupportBlock)
		items.append(contentsOf: transportBenefitsBlock)
		items.append(contentsOf: reabilitationBlock)
		items.append(contentsOf: monthlyPaymentBlock)
		items.append(hintBannerItem)
		return items
	}
}
