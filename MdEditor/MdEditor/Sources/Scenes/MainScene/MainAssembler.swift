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
	func assembly(coordinator: IMainCoordinator) -> UIViewController {
		let mainViewController = MainViewController()
		let userDefaultsManager = UserDefaultsManager()
		let filesManager = FilesManager()
		
		let presenter = MainPresenter(viewController: mainViewController)
		let menuManager = MainMenuManager()
		let recentlyFilesManager = RecentlyFilesManager(userDefaultsManager: userDefaultsManager, countOfRecently: 5)
		let interactor = MainInteractor(
			coordinator: coordinator,
			presenter: presenter,
			menuManager: menuManager,
			filesManager: filesManager,
			recentlyFilesManager: recentlyFilesManager
		)
		
		mainViewController.interactor = interactor
		
		return mainViewController
	}
}
