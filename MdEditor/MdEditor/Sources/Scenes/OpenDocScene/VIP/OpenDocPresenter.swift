//
//  OpenDocPresenter.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit

/// Протокол презентера для экрана Открыть документ.
protocol IOpenDocPresenter {
	
	/// Обрабатывает ответ на запрос получения файлов.
	/// - Parameter response: ответ на запрос получения файлов
	func present(response: OpenDocModels.Response)
}

final class OpenDocPresenter: IOpenDocPresenter {
	
	// MARK: - Private Properties
	
	private weak var viewController: IOpenDocViewController?
	
	// MARK: - Life Cycle
	
	init(viewController: IOpenDocViewController?) {
		self.viewController = viewController
	}
	
	// MARK: - Internal Methods
	
	func present(response: OpenDocModels.Response) {
		let viewModel = OpenDocModels.ViewModel(
			title: response.title,
			files: response.files
		)
		
		viewController?.render(viewModel: viewModel)
	}
}

extension OpenDocModels.FileType {
	var icon: UIImage {
		switch self {
		case .directory:
			return Asset.Icons.folder.image
		case .file:
			return Asset.Icons.doc.image
		}
	}
}
