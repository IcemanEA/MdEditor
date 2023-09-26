//
//  AboutPresenter.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Протокол презентара AboutScene.
protocol IAboutPresenter {
	/// Обрабатывает ответ на загрузку данных для AboutScene.
	/// - Parameter response: ответ при загрузке данных для AboutScene
	func present(response: AboutModels.Response)
}

/// Презентар для AboutScene.
final class AboutPresenter: IAboutPresenter {

	// MARK: - Private Properties
	
	private weak var viewController: IAboutViewController?

	// MARK: - Life Cycle
	
	init(viewController: IAboutViewController?) {
		self.viewController = viewController
	}

	// MARK: - Internal Methods
	
	func present(response: AboutModels.Response) {
		let attributedString = NSAttributedString(string: response.markdownString)
		let viewModel = AboutModels.ViewModel(attributedString: attributedString)
		viewController?.render(viewModel: viewModel)
	}
}
