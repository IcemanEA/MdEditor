//
//  CoordinatorAlertModel.swift
//  MdEditor
//
//  Created by Egor Ledkov on 11.10.2023.
//  Copyright © 2023 Ledkov Team. All rights reserved.
//

import Foundation

struct CoordinatorAlertModel {
	let title: String?
	let message: String?
	let textFields: [TextField]?
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
	
	enum ButtonStyle {
		case def
		case cancel
		case destructive
	}
	
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
	
	struct TextField {
		let placeHolder: String
	}
}
