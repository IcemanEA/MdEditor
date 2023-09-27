//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Egor Ledkov on 23.04.2023.
//

import Foundation

/// Протокол файлового менеджера.
protocol IFilesManager {
	/// Получает файлы и папки внутри указанного пути.
	/// - Parameter url: путь, внутри которого необходимо собрать информацию о вложенных файлах и папках
	/// - Returns: массив файлов и папок внутри
	func scan(path: URL) throws -> [File]
	
	/// Получаем указанную папку пользователя устройства.
	/// - Parameter type: тип размещения в памяти устрйоства
	/// - Returns: домашняя папка
	func getDeviceDirectory(_ type: FileManager.SearchPathDirectory) throws -> File?
	
	/// Получаем указанную папку в бандле приложения.
	/// - Parameter path: наименование папки
	/// - Returns: папка из бандла
	func getBundleDirectory(withPath path: String) throws -> File?
	
	func createFile(with name: String, and extension: String) throws -> URL
}

/// Класс файлового менеджера.
final class FilesManager: IFilesManager {
	
	/// Ошибки при работе с файлами.
	enum Error: Swift.Error {
		case fileNotExist
		case unKnowAttributes
		case canNotCreateFileExist
	}
	
	// MARK: - Private Properties
	
	private let fileManager = FileManager.default
	
	// MARK: - Internal Methods
	
	func scan(path: URL) throws -> [File] {
		var directories: [File] = []
		var files: [File] = []
		
		let items = try fileManager.contentsOfDirectory(atPath: path.relativePath)
		
		for item in items {
			let itemPath = path.appendingPathComponent(item)
			
			if let file = try get(from: itemPath) {
				switch file.fileType {
				case .directory:
					directories.append(file)
				case .file:
					files.append(file)
				}
			}
		}
		
		directories.append(contentsOf: files)
		return directories
	}
	
	func getDeviceDirectory(_ type: FileManager.SearchPathDirectory) throws -> File? {
		guard
			let url = try? fileManager.url(for: type, in: .userDomainMask, appropriateFor: nil, create: false)
		else { return nil }
		
		return try get(from: url)
	}
	
	func getBundleDirectory(withPath path: String) throws -> File? {
		guard
			let url = Bundle.main.url(forResource: path, withExtension: nil)
		else { return nil }
		
		return try get(from: url)
	}
	
	func createFile(with name: String, and ext: String) throws -> URL {
		var url = try fileManager.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: false
		)
		
		url = url.appendingPathComponent("\(name).\(ext)")
		
		if !fileManager.fileExists(atPath: url.path) {
			fileManager.createFile(atPath: url.path, contents: nil)
		} else {
			throw Error.canNotCreateFileExist
		}
		
		return url
	}
	
	// MARK: - Private Methods
	
	private func get(from url: URL) throws -> File? {
		if !fileManager.fileExists(atPath: url.relativePath) {
			throw Error.fileNotExist
		}
		
		let attr = try fileManager.attributesOfItem(atPath: url.relativePath)
		
		guard
			let type = attr[.type] as? FileAttributeType,
			let size = attr[.size] as? UInt64,
			let date = attr[.modificationDate] as? Date
		else { throw Error.unKnowAttributes }
		
		let file = File(
			url: url,
			fileType: type == .typeDirectory ? .directory : .file,
			size: size,
			date: date
		)
		
		return file
	}
}
