//
//  MainAssembler.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit

/// Assembler экрана главного меню приложения.
final class MainAssembler {
	/// Сборка экрана с главным меню.
	func assembly() -> UIViewController {
		let mainViewController = MainViewController()
		let filesManager = FilesManager()
		let userDefaultsManager = UserDefaultsManager()
		
		let presenter = MainPresenter(viewController: mainViewController)
		let menuManager = MainMenuManager()
		let recentlyFilesManager = RecentlyFilesManager(userDefaultsManager: userDefaultsManager, countOfRecently: 5)
		let interactor = MainInteractor(
			presenter: presenter,
			menuManager: menuManager,
			recentlyFilesManager: recentlyFilesManager
		)
		let router = MainRouter(viewController: mainViewController, filesManager: filesManager)
		
		mainViewController.interactor = interactor
		mainViewController.router = router
		
		return mainViewController
	}
}
