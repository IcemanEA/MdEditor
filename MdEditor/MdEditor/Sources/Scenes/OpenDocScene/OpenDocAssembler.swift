//
//  OpenDocAssembler.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit

/// Сборщик экрана Открыть документ.
final class OpenDocAssembler {
	
	func assembly(request: OpenDocModels.Request, coordinator: IFileManagerCoordinator) -> UIViewController {
		let viewController = OpenDocViewController(request: request)
		
		let filesManager = FilesManager()
		let filesWorker = OpenDocFilesWorker(filesManager: filesManager)

		let userDefaultsManager = UserDefaultsManager()
		let recentlyFilesManager = RecentlyFilesManager(userDefaultsManager: userDefaultsManager, countOfRecently: 5)
		
		let presenter = OpenDocPresenter(viewController: viewController)
		let interactor = OpenDocInteractor(
			coordinator: coordinator,
			presenter: presenter,
			filesWorker: filesWorker,
			recentlyFilesManager: recentlyFilesManager
		)
		
		viewController.interactor = interactor
		
		return viewController
	}
}
