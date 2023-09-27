//
//  AboutViewController.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit
import PinLayout

/// Протокол ViewController'a AboutScene.
protocol IAboutViewController: AnyObject {
	
	/// Формирует внешний вид экрана на основе переданной модели.
	/// - Parameter viewModel: модель, на основе которой формируется UI экрана
	func render(viewModel: AboutModels.ViewModel)
}

/// Контроллер главного меню приложения.
final class AboutViewController: UIViewController {

	// MARK: - Internal Properties

	var interactor: IAboutInteractor?

	// MARK: - Private Properties
	
	private lazy var textView = createTextView()

	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
		addSubviews()
		layout()
		
		interactor?.fetchAboutData()
	}
	
	// MARK: - Private Methods
	
	private func setupView() {
		title = L10n.Localizable.MainMenu.aboutApp
		view.backgroundColor = Theme.backgroundColor
		navigationController?.navigationBar.tintColor = Theme.black
		navigationController?.navigationBar.accessibilityIdentifier = AccessibilityIdentifier.AboutScene.title
	}
	
	private func addSubviews() {
		view.addSubview(textView)
	}
	
	private func layout() {
		textView.pin
			.all()
			.margin(Sizes.Padding.normal)
	}
	
	func setupText(_ text: NSAttributedString) {
		let range = (text.string as NSString).range(of: text.string)
		let mutableAttributedString = NSMutableAttributedString(attributedString: text)
		mutableAttributedString.addAttribute(.foregroundColor, value: Theme.black, range: range)
		
		textView.attributedText = mutableAttributedString
		
		textView.textAlignment = .justified
		textView.translatesAutoresizingMaskIntoConstraints = false
	}
}

// MARK: - IAboutViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModels.ViewModel) {
		setupText(viewModel.attributedString)
	}
}

// MARK: - Create UI Components

private extension AboutViewController {
	func createTextView() -> UITextView {
		let textView = UITextView()
		textView.isEditable = false
		textView.backgroundColor = Theme.backgroundColor
		textView.accessibilityIdentifier = AccessibilityIdentifier.AboutScene.textView
		return textView
	}
}
