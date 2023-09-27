//
//  AboutModels.swift
//  MdEditor
//
//  Created by Constantin on 21.04.2023.
//

import Foundation

/// Модели для экрана AboutScene.
enum AboutModels {
	/// Ответ на загрузку данных для формирования AboutScene.
	struct Response {
		let markdownString: String
	}
	
	/// Данные для AboutScene.
	struct ViewModel {
		let attributedString: NSAttributedString
	}
}
