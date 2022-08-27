//
//  SpecialOpportunitiesView.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 18.07.2022.

import DesignSystem
import SBFoundation

/// Вью экрана Специальные возможности
final class SpecialOpportunitiesView: UIViewController {
	// MARK: - Properties
	/// Презентер модуля
	var presenter: SpecialOpportunitiesPresenterProtocol?

	// MARK: - UI elements
	private lazy var formView: DSNFormView = {
		let formView = DSNFormView()
		formView.translatesAutoresizingMaskIntoConstraints = false
		formView.estimatedRowHeight = UITableView.automaticDimension
		formView.estimatedSectionHeaderHeight = UITableView.automaticDimension
		formView.sectionFooterHeight = UITableView.automaticDimension
		return formView
	}()

	private lazy var preloaderView: PreloaderView = {
		let loaderView = PreloaderView()
		loaderView.translatesAutoresizingMaskIntoConstraints = false
		return loaderView
	}()

	// MARK: - Lifecycle
	override func loadView() {
		view = BackgroundAtom(tokenName: .background0)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.dsn_style = .neutral
		addSubviews()
		fetchData()
	}

	// MARK: - Private functions
	private func fetchData() {
		preloaderView.setVisibilityAnimated(shouldHide: false)
		presenter?.didLoadView()
	}

	private func addSubviews() {
		view.addSubview(formView)
		view.addSubview(preloaderView)

		NSLayoutConstraint.activate([
			preloaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			preloaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			preloaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			preloaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			formView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			formView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			formView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	private func popViewController() {
		navigationController?.popViewController(animated: UIView.areAnimationsEnabled)
	}
}

// MARK: - SpecialOpportunitiesViewProtocol
extension SpecialOpportunitiesView: SpecialOpportunitiesViewProtocol {
	func show(items: [DSNFormItemDelegate]) {
		stopLoader()
		formView.setItems(items, animated: false)
	}

	func stopLoader() {
		preloaderView.hide()
	}
}
