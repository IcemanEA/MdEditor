//
//  MainInteractor.swift
//  MdEditor
//

import Foundation

/// Протокол интерактора главного меню.
protocol IMainInteractor {
	/// Загружает данные для главного меню.
	func fetchData()
	
	/// Показывает экран Открыть документ.
	func showOpenDocScreen()
	
	/// Показывает экран Новый документ.
	func showNewDocAlert()
	
	/// Показывает экран О приложении.
	func showAboutScreen()
	
	/// Открываем файл.
	func showFile(_ url: URL)
}

/// Интерактор главного меню.
final class MainInteractor: IMainInteractor {
	
	// MARK: - Private Properties
	
	private let coordinator: IMainCoordinator
	private let presenter: IMainPresenter
	private let menuManager: IMainMenuManager
	private let filesManager: IFilesManager
	private let recentlyFilesManager: IRecentlyFilesManager
	
	// MARK: - Life Cycle
	
	init(
		coordinator: IMainCoordinator,
		presenter: IMainPresenter,
		menuManager: IMainMenuManager,
		filesManager: IFilesManager,
		recentlyFilesManager: IRecentlyFilesManager
	) {
		self.coordinator = coordinator
		self.presenter = presenter
		self.menuManager = menuManager
		self.filesManager = filesManager
		self.recentlyFilesManager = recentlyFilesManager
	}
	
	deinit {
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
	
	// MARK: - Coordinator Methods
	
	func showOpenDocScreen() {
		coordinator.showFileManagerFlow(path: nil)
	}
	
	func showNewDocAlert() {
		let okButton = CoordinatorAlertModel.Button(title: L10n.Localizable.Alert.Button.ok, textAction: { [weak self] name in
			do {
				if let url = try self?.filesManager.createFile(with: name, and: "md") {
					self?.showFile(url)
				}
			} catch {
				let warningData = CoordinatorAlertModel(
					title: L10n.Localizable.Alert.Title.warning,
					message: error.localizedDescription
				)
				self?.coordinator.showAlert(with: warningData)
			}
		})
		
		let data = CoordinatorAlertModel(
			title: L10n.Localizable.MainMenu.newDocument,
			textFields: [
				CoordinatorAlertModel.TextField(placeHolder: L10n.Localizable.Alert.PlaceHolder.newDoc)
			],
			buttons: [
				okButton,
				CoordinatorAlertModel.Button(title: L10n.Localizable.Alert.Button.cancel, style: .destructive)
			]
		)
		coordinator.showAlert(with: data)
	}
	
	func showAboutScreen() {
		coordinator.showAboutScene()
	}
	
	func showFile(_ url: URL) {
//		let url = url.deletingLastPathComponent()
		
		coordinator.showFileManagerFlow(path: url)
	}
}
