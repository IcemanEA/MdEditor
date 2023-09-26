//
//  UserDefaultsManager.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Тип параметра для хранения в хранилище UserDefaults.
enum UserDefaultsName: String {
	case recentlyFiles
}

/// Протокол менеджера для работы с хранилищем UserDefaults.
protocol IUserDefaultsManager {
	
	/// Получить данные из UserDefaults.
	/// - Parameter name: тип параметра
	/// - Returns: дата
	func get(_ name: UserDefaultsName) -> Data?
	
	/// Сохраняем данные в личное хранилище.
	/// - Parameters:
	///   - name: тип параметра
	///   - data: дата для сохранения
	func set(_ name: UserDefaultsName, with data: Data)
}

/// Класс менеджера для работы с хранилищем UserDefaults.
final class UserDefaultsManager: IUserDefaultsManager {
	
	// MARK: - Private properties
	
	private let storage = UserDefaults.standard
	
	// MARK: - Internal Methods
	
	func get(_ name: UserDefaultsName) -> Data? {
		storage.data(forKey: name.rawValue)
	}
	
	func set(_ name: UserDefaultsName, with data: Data) {
		storage.set(data, forKey: name.rawValue)
	}
}
