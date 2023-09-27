//
//  RecentlyFilesManager.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Протокол помощника для получения файлов по указанному пути.
protocol IRecentlyFilesManager {
	
	/// Получить список с информацией о недавно открытых файлах.
	/// - Returns: список структур хранения недавно открытых файлов
	func getFiles() -> [RecentlyItem]
	
	/// Добавляем информацию об открытом файле в хранилище.
	/// - Parameters:
	///   - url: ссылка на файл
	///   - previewText: текст превью
	func addFileToStorage(url: URL, previewText: String)
}

final class RecentlyFilesManager: IRecentlyFilesManager {
	
	// MARK: - Private Properties
	
	private let userDefaultsManager: IUserDefaultsManager
	private let countOfRecently: Int
	
	// MARK: - Life Cycle
	
	/// Создаем воркер для работы с ранее открытыми файлами.
	/// - Parameters:
	///   - userDefaultsManager: менеджер личного хранилища
	///   - countOfRecently: количество недавно открытых файлов
	init(userDefaultsManager: IUserDefaultsManager, countOfRecently: Int) {
		self.userDefaultsManager = userDefaultsManager
		self.countOfRecently = countOfRecently
	}
	
	// MARK: - Internal Methods
	
	func getFiles() -> [RecentlyItem] {
		if let storageItems = userDefaultsManager.get(.recentlyFiles) {
			let jsonDecoder = JSONDecoder()
			
			do {
				let recentlyItems = try jsonDecoder.decode([RecentlyItem].self, from: storageItems)
				
				return recentlyItems
			} catch {
				// swiftlint:disable:next print_using
				print(error.localizedDescription)
			}
		}
		
		return []
	}
	
	func addFileToStorage(url: URL, previewText: String) {
		var currentFiles = getFiles()
		
		if let indexToRemove = currentFiles.firstIndex(where: { $0.url.lastPathComponent == url.lastPathComponent }) {
			currentFiles.remove(at: indexToRemove)
		}

		let recentlyFile = RecentlyItem(url: url, previewText: previewText)
		currentFiles.insert(recentlyFile, at: 0)
		
		if currentFiles.count > countOfRecently {
			currentFiles = currentFiles.dropLast(1)
		}
		
		let jsonEncoder = JSONEncoder()
		if let recentlyData = try? jsonEncoder.encode(currentFiles) {
			userDefaultsManager.set(.recentlyFiles, with: recentlyData)
		}
	}
}
