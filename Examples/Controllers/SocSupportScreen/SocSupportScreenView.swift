//
//  SocSupportScreenView.swift
//  PayrollCard
//
//  Created by Гермек Александр Георгиевич on 28.07.2022.
// 
//
import DesignSystem

/// Вью модуля
final class SocSupportScreenView: UIViewController, BottomSheetModalPresentationProtocol {
	// MARK: - BottomSheetModalPresentationProtocol

	var scrollView: UIScrollView? { formView }
	var shortFormHeight: BottomSheetModalHeight = BottomSheetModalHeight()
	var longFormHeight: BottomSheetModalHeight = BottomSheetModalHeight()
	var anchorModalToLongForm: Bool { false }
	var allowsClipToTop: Bool { true }
	var accessibilityDragLineLabel: String { "" }

	func shouldTransition(to state: BottomSheetModalState.PresentationState) -> Bool { true }
	func willTransition(to state: BottomSheetModalState.PresentationState) {}
	func bottomSheetModalWillDismiss(type: BottomSheetModalState.DissmissType) {}
	func bottomSheetModalDidDismiss(type: BottomSheetModalState.DissmissType) {}

	// MARK: - Properties
	/// Презентер модуля
	var presenter: SocSupportScreenPresenterProtocol?

	private var tableContentHeight: CGFloat { formView.contentSize.height }
	private var threeSecondsScreenHeight: CGFloat { UIScreen.main.bounds.height * 3 / 2 }
	private var shortSheetHeight: CGFloat { min(tableContentHeight, threeSecondsScreenHeight) }

	// MARK: - UI elements
	private lazy var formView: DSNFormView = {
		let formView = DSNFormView()
		formView.translatesAutoresizingMaskIntoConstraints = false
		formView.estimatedRowHeight = UITableView.automaticDimension
		formView.estimatedSectionHeaderHeight = UITableView.automaticDimension
		formView.sectionFooterHeight = UITableView.automaticDimension
		return formView
	}()

	// MARK: - Lifecycle
	override func loadView() {
		view = BackgroundAtom(tokenName: .background0)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		addSubviews()
		presenter?.didLoadView()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		formView.layoutIfNeeded()
		formView.contentOffset = .zero
		shortFormHeight.contentHeight = shortSheetHeight
		longFormHeight.contentHeight = tableContentHeight
		bottomSheetModalSetNeedsLayoutUpdate()
		bottomSheetModalTransition(to: .longForm)
	}

	// MARK: - Private functions
	private func addSubviews() {
		view.addSubview(formView)

		NSLayoutConstraint.activate([
			formView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			formView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			formView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

// MARK: - SocSupportScreenViewProtocol
extension SocSupportScreenView: SocSupportScreenViewProtocol {
	func show(items: [DSNFormItemDelegate]) {
		formView.setItems(items, animated: UIView.areAnimationsEnabled)
	}
}

// MARK: - DSNFormViewDelegate
extension SocSupportScreenView: DSNFormViewDelegate {
	func formView(_ formView: DSNFormView, didSelectItem item: DSNFormItemDelegate) -> Bool {
		guard let indexPath = formView.indexPath(forItem: item) else { return false }
		formView.deselectRow(at: indexPath, animated: true)
		return false
	}
}
