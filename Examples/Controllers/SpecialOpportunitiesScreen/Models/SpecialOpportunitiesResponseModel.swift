//
//  SpecialOpportunitiesResponseModel.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.

/// Модель сетевого ответа для экрана Специальные возможности
struct SpecialOpportunitiesResponseModel: Decodable {
	/// Признак успеха обработки запроса
	let success: Bool
	/// Тело ответа
	let body: SpecialOpportunitiesBodyModel?
}

/// Модель тела ответа
struct SpecialOpportunitiesBodyModel: Decodable {
	/// Хэдер экрана
	let header: SpecialOpportunitiesHeaderModel
	/// Блок с кнопками
	let serviceButtons: [SocialSupportServiceButton]
	/// Данные для всплывающей шторки Социальная поддержка
	let socialSupportBottomSheet: SocialSupportBottomSheetModel

	private enum CodingKeys: String, CodingKey {
		case header
		case serviceButtons
		case socialSupportBottomSheet = "socSupport"
	}
}

/// Хэдер экрана Специальные возможности
struct SpecialOpportunitiesHeaderModel: Decodable {
	/// Заголовок экрана
	let title: String
	/// Подзаголовок экрана
	let subtitle: String
	/// Событие аналитики
	let eventForAnalytic: String
}

/// Модель кнопки(ячейки) экрана Специальные возможности
struct SocialSupportServiceButton: Decodable {
	/// Заголовок кнопки
	let title: String
	/// Подзаголовок кнопки
	let subtitle: String?
	/// Иконка справа
	let icon: String?
	/// Диплинк для перехода
	let url: String?
	/// Событие аналитики по нажатию
	let eventForAnalytic: String
	/// Тип для определения куда переходить по нажатию
	let type: String?
}

/// Данные для всплывающей шторки Социальная поддержка
struct SocialSupportBottomSheetModel: Decodable {
	/// Заголовок шторки
	let title: String
	/// Событие аналитики при открытии шторки
	let eventForAnalytic: String
	/// Блок с кнопками первой секции
	let commonBlock: ButtonsSection
	/// Блок с Транспортными льготами
	let transportBenefits: ButtonsSection
	/// Блок Реабилитация
	let reabilitation: ButtonsSection
	/// Блок Ежемесячная выплата
	let monthlyPayment: ButtonsSection
	/// Секция Рассчитать социальные выплаты
	let calculateSocialSupport: CalculateSocialSupport
}

/// Секция с кнопками для различных разделов в шторке
struct ButtonsSection: Decodable {
	/// Заголовок секции
	let title: String?
	/// Блок кнопок в секции
	let socSupportButtons: [SocialSupportButton]
}

/// Модель кнопки(ячейки) для шторки Соцподдержка
struct SocialSupportButton: Decodable {
	/// Заголовок кнопки
	let title: String
	/// Иконка справа
	let icon: String?
	/// Диплинк для перехода
	let url: String?
	/// Событие аналитики по нажатию
	let eventForAnalytic: String
}

/// Секция Рассчитать социальные выплаты
struct CalculateSocialSupport: Decodable {
	/// Заголовок
	let title: String
	/// Описание
	let description: String?
	/// Заголовок для кнопки
	let buttonTitle: String
	/// Имя иконки
	let icon: String?
	/// Диплинк для перехода
	let url: String?
	/// Событие аналитики при нажатии на кнопку
	let eventForAnalytic: String
}
