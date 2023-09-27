//
//  MainMenuManager.swift
//  MdEditor
//
//  Created by Egor Ledkov on 20.04.2023.
//

import Foundation

/// Протокол менеджера главного меню приложения.
protocol IMainMenuManager {
	/// Возвращает пункты главного меню приложения.
	/// - Returns: массив пунктов меню приложения в необходимом порядке
	func getMenuItems() -> [MainMenuItem]
}

/// Менеджер главного меню приложения. Формирует пункты меню.
final class MainMenuManager: IMainMenuManager {
	
	// MARK: - Internal Methods
	
	func getMenuItems() -> [MainMenuItem] {
		MainMenuItem.allCases
	}
}

/// Перечисление главных пунктов меню.
enum MainMenuItem: CaseIterable {
	case openDocument
	case newDocument
	case aboutApp
}
