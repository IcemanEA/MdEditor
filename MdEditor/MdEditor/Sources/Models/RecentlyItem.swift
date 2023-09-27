//
//  RecentlyFile.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Структура хранения и отображения недавно открытого файла.
struct RecentlyItem: Codable {
	let url: URL
	let previewText: String
}
