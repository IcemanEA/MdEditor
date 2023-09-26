//
//  OpenDocAssembler.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit

/// Сборщик экрана Открыть документ.
enum OpenDocAssembler {
	
	/// Создает vieController.
	/// - Returns: viewController экрана Открыть документ
	static func createController(request: OpenDocModels.Request) -> UIViewController {
		let viewController = OpenDocViewController(request: request)
		
		let filesManager = FilesManager()
		let filesWorker = OpenDocFilesWorker(filesManager: filesManager)

		let userDefaultsManager = UserDefaultsManager()
		let recentlyFilesManager = RecentlyFilesManager(userDefaultsManager: userDefaultsManager, countOfRecently: 5)
		
		let presenter = OpenDocPresenter(viewController: viewController)
		let interactor = OpenDocInteractor(presenter: presenter, filesWorker: filesWorker)
		let router = OpenDocRouter(viewController: viewController, recentlyFilesManager: recentlyFilesManager)
		
		viewController.interactor = interactor
		viewController.router = router
		
		return viewController
	}
}
