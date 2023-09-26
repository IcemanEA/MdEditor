//
//  File.swift
//  MdEditor
//
//  Created by Egor Ledkov on 23.04.2023.
//

import Foundation

/// Класс описывающий параметры файла или папки.
struct File {
	let url: URL
	let fileType: FileType
	let size: UInt64
	let date: Date
}

/// Тип файла (файл или папка).
enum FileType {
	case file
	case directory
}
