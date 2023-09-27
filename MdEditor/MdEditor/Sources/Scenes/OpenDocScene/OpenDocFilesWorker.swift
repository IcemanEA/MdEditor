//
//  OpenDocFilesWorker.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Протокол помощника для получения файлов по указанному пути.
protocol IOpenDocFilesWorker {
	
	/// Получает файлы по указанному пути.
	/// - Parameters:
	///   - atPath: путь для файла или папки в указанном корневом каталоге. Если nil, то возвращается корневой каталог
	/// - Returns: массив папок и файлов для указанного пути
	func getFiles(atPath path: URL?) -> [File]
}

final class OpenDocFilesWorker: IOpenDocFilesWorker {
	
	// MARK: - Private Properties
	
	private let filesManager: IFilesManager
	
	// MARK: - Life Cycle
	
	init(filesManager: IFilesManager) {
		self.filesManager = filesManager
	}
	
	// MARK: - Internal Methods
	
	func getFiles(atPath path: URL?) -> [File] {
		guard let path else { return getRootDirectories() }
		
		do {
			return try filesManager.scan(path: path)
		} catch {
			// swiftlint:disable:next print_using
			print(error.localizedDescription)
		}
		
		return []
	}
	
	// MARK: - Private Methods
	
	private func getRootDirectories() -> [File] {
		do {
			var files: [File] = []
			
			if let homeFile = try filesManager.getDeviceDirectory(.documentDirectory) {
				files.append(homeFile)
			}
			
			if let bundleFile = try filesManager.getBundleDirectory(withPath: "Examples") {
				files.append(bundleFile)
			}
			
			return files
		} catch {
			// swiftlint:disable:next print_using
			print(error.localizedDescription)
		}
		
		return []
	}
}

// MARK: - FilesManager.Error: LocalizedError

extension FilesManager.Error: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .fileNotExist:
			return L10n.Localizable.FilesManager.Error.fileNotExist
		case .unKnowAttributes:
			return L10n.Localizable.FilesManager.Error.unKnowAttributes
		case .canNotCreateFileExist:
			return L10n.Localizable.FilesManager.Error.canNotCreateFileExist
		}
	}
}
