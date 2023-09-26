//
//  OpenDocModels.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Модели экрана Открыть документ.
enum OpenDocModels {
	
	/// Тип файла (файл или папка).
	enum FileType {
		case file
		case directory
	}
	
	/// Тип данных для передачи данных в VIP цикле.
	struct File {
		let url: URL
		let type: FileType
		let name: String
	}
	
	/// Запрос для получения перечня файлов в директории.
	struct Request {
		let directoryPath: URL?
	}
	
	/// Ответ на запрос файлов в директории.
	struct Response {
		let title: String
		let files: [File]
	}
	
	/// Модель для рендеринга перечня файлов.
	struct ViewModel {
		let title: String
		let files: [File]
		
		/// Хелпер для получения файла по indexPath.
		/// - Parameter indexPath: indexPath, для которого необходимо получить файл
		/// - Returns: файл для указанного indexPath
		func getFile(at indexPath: IndexPath) -> File {
			files[indexPath.row]
		}
	}
}
