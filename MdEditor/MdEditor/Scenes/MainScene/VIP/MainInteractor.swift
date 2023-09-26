//
//  MainInteractor.swift
//  MdEditor
//

import Foundation

/// Протокол интерактора главного меню.
protocol IMainInteractor {
	/// Загружает данные для главного меню.
	func fetchData()
}

/// Интерактор главного меню.
final class MainInteractor: IMainInteractor {
	
	// MARK: - Private Properties
	
	private let presenter: IMainPresenter
	private let menuManager: IMainMenuManager
	private let recentlyFilesManager: IRecentlyFilesManager
	
	// MARK: - Life Cycle
	
	init(presenter: IMainPresenter, menuManager: IMainMenuManager, recentlyFilesManager: IRecentlyFilesManager) {
		self.presenter = presenter
		self.menuManager = menuManager
		self.recentlyFilesManager = recentlyFilesManager
	}
	
	// MARK: - Internal Methods
	
	func fetchData() {
		let data = menuManager.getMenuItems()
		let recentlyFiles = recentlyFilesManager
			.getFiles()
			.map {
				MainModels.RecentlyItem(url: $0.url, previewText: $0.previewText)
			}
		let response = MainModels.Response(mainMenuItems: data, recentlyFiles: recentlyFiles)
		
		presenter.present(response: response)
	}
}
