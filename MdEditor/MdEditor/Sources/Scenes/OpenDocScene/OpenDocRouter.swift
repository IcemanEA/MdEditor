//
//  OpenDocRouter.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Протокол роутера экрана Открыть документ.
protocol IOpenDocRouter {
	
	/// Открывает следующий экран Открыть документ для указанной папки.
	/// - Parameter request: запрос, который указывает папку,
	/// содержимое которой необходимо отобразить на следующем экране Открыть документ
	func showNextOpenDocScreen(request: OpenDocModels.Request)
	
	/// Открываем файл для редактирования и просмотра.
	/// - Parameter url: Ссылка на файл
	func showFile(by url: URL)
}

final class OpenDocRouter: IOpenDocRouter {
	// MARK: - Private Properties
	
	private weak var viewController: IOpenDocViewController?
	private let recentlyFilesManager: IRecentlyFilesManager
	
	// MARK: - Life Cycle
	
	init(viewController: IOpenDocViewController, recentlyFilesManager: IRecentlyFilesManager) {
		self.viewController = viewController
		self.recentlyFilesManager = recentlyFilesManager
	}
	
	// MARK: - Internal Methods
	
	func showNextOpenDocScreen(request: OpenDocModels.Request) {
		let openDocController = OpenDocAssembler.createController(request: request)
		viewController?.navigationController?.pushViewController(openDocController, animated: true)
	}
	
	func showFile(by url: URL) {
		if let fileStrings = try? String(contentsOfFile: url.path) {
			
			recentlyFilesManager.addFileToStorage(url: url, previewText: fileStrings)
		}
	}
}
