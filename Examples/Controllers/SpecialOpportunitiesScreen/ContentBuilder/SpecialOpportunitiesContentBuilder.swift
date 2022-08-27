//
//  SpecialOpportunitiesContentBuilder.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 27.07.2022.
// 
//

import DesignSystem
import SBFoundation

/// Протокол провайдера экрана Спец возможности
protocol SpecialOpportunitiesContentBuilderProtocol: AnyObject {
	/// Обработчик событий по тапу на ячейку
	var delegate: SpecialOpportunitiesContentBuilderDelegate? { get set }
	/// Функция получения айтемов для FormView
	/// - Parameter model: body модели запроса
	/// - Returns: массив айтемов
	func makeItemsFrom(model: SpecialOpportunitiesBodyModel) -> [DSNFormItemDelegate]

	/// Создает алерт с ошибкой
	/// - Returns: алерт
	func makeErrorAlert() -> UIViewController
}

/// Протокол обработчика событий провайдера
protocol SpecialOpportunitiesContentBuilderDelegate: AnyObject {
	/// Функция обработки нажатия на ячейку
	/// - Parameters:
	///   - type: тип ячейки, служит для определения пушить экран или открывать диплинк
	///   - url: диплинк
	///   - eventForAnalytic: событие аналитики для клика по ячейке
	func itemTapped(_ type: String?, _ url: String?, _ eventForAnalytic: String)
	/// Нажата кнопка Понятно на алерте с ошибкой
	func errorAlertCloseButtonTapped()
}

/// Класс-провайдер контента экрана Спец возможности
final class SpecialOpportunitiesContentBuilder {
	/// Обработчик событий по тапу на ячейку
	weak var delegate: SpecialOpportunitiesContentBuilderDelegate?

	private enum Constants {
		static let itemColor = ColorToken(
			lightThemeColor: UIColor.DesignSystemPalette.blue0,
			darkThemeColor: UIColor.DesignSystemPalette.blue85
		)
	}

	// MARK: - Private functions
	private func createHeaderItem(title: String, subtitle: String) -> DSNFormItemDelegate {
		return SectionHeaderFormItem(title: title, subtitle: subtitle)
	}

	private func createRichCellItems(from models: [SocialSupportServiceButton]) -> [DSNFormItemDelegate] {
		var richCellItems: [DSNFormItemDelegate] = []

		richCellItems = models.compactMap { buttonModel in
			let iconImage = IconsMapper().semanticImage(semanticName: buttonModel.icon)?.image ?? UIImage()
			var richCell = RichCell.Base(style: .default,
										 icon: .icon(iconImage),
										 iconColor: Constants.itemColor,
										 title: Text(value: buttonModel.title),
										 subtitle: Text(value: buttonModel.subtitle ?? ""),
										 caption: nil)
			richCell.didTapCallback = { [weak delegate] model in
				delegate?.itemTapped(buttonModel.type, buttonModel.url, buttonModel.eventForAnalytic)
				return model
			}
			return richCell.makeItem()
		}
		return richCellItems
	}

	@objc private func addAction() {
		delegate?.errorAlertCloseButtonTapped()
	}
}

// MARK: - SpecialOpportunitiesContentBuilderProtocol
extension SpecialOpportunitiesContentBuilder: SpecialOpportunitiesContentBuilderProtocol {
	func makeErrorAlert() -> UIViewController {
		// AcceptButton
		let styleName: AcceptButton.Style.Name = .accept
		let buttonTitle = SBFLang("Понятно")
		let button = AcceptButton(styleName: styleName, title: buttonTitle)
		button.addTarget(self, action: #selector(addAction), for: .touchUpInside)

		// Alert
		let image: SemanticImage = .ill256ConstructionZone
		let title: String = SBFLang("Сервис временно недоступен")
		let subtitle: String = SBFLang("Пожалуйста, попробуйте через 5 минут или позже")

		let alertVC = RichAlertViewController(image: image,
										  title: title,
										  subtitle: subtitle,
										  buttons: [button])
		return alertVC
	}

	func makeItemsFrom(model: SpecialOpportunitiesBodyModel) -> [DSNFormItemDelegate] {
		let headerItem = createHeaderItem(title: model.header.title, subtitle: model.header.subtitle)
		let richItems = createRichCellItems(from: model.serviceButtons)
		return [headerItem, SpacerItem()] + richItems
	}
}
