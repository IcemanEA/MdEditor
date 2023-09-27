//
//  MainPresenter.swift
//  MdEditor
//

import Foundation

/// Протокол презентара главного меню.
protocol IMainPresenter {
	/// Обрабатывает ответ на загрузку данных для главного экрана.
	/// - Parameter response: ответ при загрузке данных для главного экрана.
	func present(response: MainModels.Response)
}

/// Презентер главного меню.
final class MainPresenter: IMainPresenter {
	
	// MARK: - Private Properties
	
	private weak var viewController: IMainViewController?
	
	// MARK: - Life Cycle
	
	init(viewController: IMainViewController) {
		self.viewController = viewController
	}
	
	// MARK: - Internal Methods
	
	func present(response: MainModels.Response) {
		let menuItems = generateMenuItems(response: response)
		let recentlyItems = generateRecentlyFiles(response: response)
		let viewModel = MainModels.ViewModel(menuItems: menuItems, recentlyItems: recentlyItems)
		
		viewController?.render(viewModel: viewModel)
	}
	
	// MARK: - Private Methods
	
	private func generateMenuItems(response: MainModels.Response) -> [MainModels.ViewModel.MenuItem] {
		var menuItems = [MainModels.ViewModel.MenuItem]()
		
		response.mainMenuItems.forEach {
			let title: String
			let icon: String
			
			switch $0 {
			case .openDocument:
				title = L10n.Localizable.MainMenu.openDocument
				icon = Asset.Icons.folder.name
			case .newDocument:
				title = L10n.Localizable.MainMenu.newDocument
				icon = Asset.Icons.docFill.name
			case .aboutApp:
				title = L10n.Localizable.MainMenu.aboutApp
				icon = Asset.Icons.questionMark.name
			}
			
			let menuItem = MainModels.ViewModel.MenuItem(icon: icon, type: $0, title: title)
			menuItems.append(menuItem)
		}
		
		return menuItems
	}
	
	private func generateRecentlyFiles(response: MainModels.Response) -> [MainModels.RecentlyItem] {
		var recentlyFiles: [MainModels.RecentlyItem] = []
		
		response.recentlyFiles.forEach { file in
			let url = file.url
			let previewText = file.previewText
			let recentlyFile = MainModels.RecentlyItem(url: url, previewText: previewText)
			
			recentlyFiles.append(recentlyFile)
		}
		
		return recentlyFiles
	}
}
