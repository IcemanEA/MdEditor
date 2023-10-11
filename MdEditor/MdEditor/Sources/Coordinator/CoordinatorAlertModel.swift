//
//  CoordinatorAlertModel.swift
//  MdEditor
//
//  Created by Egor Ledkov on 11.10.2023.
//  Copyright © 2023 Ledkov Team. All rights reserved.
//

import Foundation

/// Структура  модели данных для отображения Alert через координатор
struct CoordinatorAlertModel {
	/// Заголовок.
	let title: String?
	/// Текст сообщения.
	let message: String?
	/// Текстовые поля.
	let textFields: [TextField]?
	/// Кнопки
	let buttons: [Button]
	
	init(
		title: String? = nil,
		message: String? = nil,
		textFields: [TextField]? = nil,
		buttons: [Button]? = nil
	) {
		self.title = title
		self.message = message
		self.textFields = textFields
		if let buttons {
			self.buttons = buttons
		} else {
			self.buttons = [CoordinatorAlertModel.Button(title: L10n.Localizable.Alert.Button.ok)]
		}
	}
}

// MARK: - Button

extension CoordinatorAlertModel {
	
	/// Стиль кнопки в алерте.
	enum ButtonStyle {
		case def
		case cancel
		case destructive
	}
	
	/// Кнопка в модели данных.
	struct Button {
		let title: String
		let style: ButtonStyle
		let action: (() -> Void)?
		let textAction: ((String) -> Void)?

		init(
			title: String,
			style: ButtonStyle = .def,
			action: (() -> Void)? = nil,
			textAction: ((String) -> Void)? = nil
		) {
			self.title = title
			self.style = style
			self.action = action
			self.textAction = textAction
		}
	}
}

// MARK: - TextField

extension CoordinatorAlertModel {
	
	/// Текстовое поле в модели данных.
	struct TextField {
		let placeHolder: String
	}
}
