//
//  MainRouter.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit

/// Протокол роутера для главного меню приложения.
protocol IMainRouter {
	/// Показывает экран Открыть документ.
	func showOpenDocScreen()
	
	/// Показывает экран Новый документ.
	func showNewDocScreen()
	
	/// Показывает экран О приложении.
	func showAboutScreen()
	
	/// Открываем файл.
	func showFile(_ url: URL)
}

/// Роутер для главного меню приложения.
final class MainRouter: IMainRouter {
	
	// MARK: - Private Properties
	
	private weak var viewController: IMainViewController?
	private let filesManager: IFilesManager
	
	// MARK: - Life Cycle
	
	init(viewController: IMainViewController, filesManager: IFilesManager) {
		self.viewController = viewController
		self.filesManager = filesManager
	}
	
	// MARK: - Internal Methods
	
	func showOpenDocScreen() {
		let request = OpenDocModels.Request(directoryPath: nil)
		let openDocController = OpenDocAssembler.createController(request: request)
		
		viewController?.navigationController?.pushViewController(openDocController, animated: true)
	}
	
	func showNewDocScreen() {
		let alert = UIAlertController.createAlert(withTitle: L10n.MainMenu.newDocument, andMessage: "")
		alert.action(withText: L10n.Alert.PlaceHolder.newDoc) { [weak self] name in
			do {
				if let url = try self?.filesManager.createFile(with: name, and: "md") {
					self?.showFile(url)
				}
			} catch {
				self?.showAlert(L10n.Alert.Title.warning, withMessage: error.localizedDescription)
			}
		}
		
		viewController?.present(alert, animated: true)
	}
	
	func showAboutScreen() {
		let aboutSceneViewController = AboutAssembler().assembly()
		viewController?.navigationController?.pushViewController(aboutSceneViewController, animated: true)
	}
	
	func showFile(_ url: URL) {
		let url = url.deletingLastPathComponent()
		
		let request = OpenDocModels.Request(directoryPath: url)
		let openDocController = OpenDocAssembler.createController(request: request)
		
		viewController?.navigationController?.pushViewController(openDocController, animated: true)
	}
	
	private func showAlert(_ title: String, withMessage message: String = "") {
		let alert = UIAlertController.createAlert(withTitle: title, andMessage: message)
		let action = UIAlertAction(title: L10n.Alert.Button.ok, style: .cancel)
		alert.addAction(action)
		
		viewController?.present(alert, animated: true)
	}
}
