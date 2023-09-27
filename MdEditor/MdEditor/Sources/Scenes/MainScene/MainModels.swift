//
//  MainModels.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Модели для экрана главного меню.
enum MainModels {
	
	/// Элемент отображения недавно открытых файлов.
	struct RecentlyItem: Codable {
		let url: URL
		let previewText: String
		
		var name: String {
			url.lastPathComponent
		}
	}

	/// Ответ на загрузку данных для формирования главного меню.
	struct Response {
		let mainMenuItems: [MainMenuItem]
		let recentlyFiles: [RecentlyItem]
	}
	
	/// Данные для пунктов меню.
	struct ViewModel {
		struct MenuItem {
			let icon: String
			let type: MainMenuItem
			let title: String
		}
		
		/// Элементы меню.
		let menuItems: [MenuItem]
		
		/// Список ранее открытых документов.
		let recentlyItems: [RecentlyItem]
		
		/// Хелпер для получения пункта меню по indexPath.
		/// - Parameter indexPath: indexPath из таблицы меню
		/// - Returns: пункт меню для указанного indexPath
		func item(at indexPath: IndexPath) -> MenuItem {
			menuItems[indexPath.row]
		}
	}
}
