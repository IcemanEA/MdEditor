//
//  Flow.swift
//  MdEditor
//
//  Created by Egor Ledkov on 07.10.2023.
//  Copyright © 2023 Ledkov Team. All rights reserved.
//

import Foundation

/// Перечисление основных сценариев приложения.
enum Flow {
	
	/// Стартовый сценарий всего приложения. Используется для AppCoordinator.
	case app
	
	/// Стартовый экран для отображения списка документов и меню.
	case main
	
	/// Навигация по документам и работа с ними.
	case fileManager(path: URL?)
}

extension Flow: Comparable {
	static func < (lhs: Flow, rhs: Flow) -> Bool {
		true
	}
}
