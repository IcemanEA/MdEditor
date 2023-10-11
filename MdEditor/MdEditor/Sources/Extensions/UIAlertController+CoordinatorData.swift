//
//  UIAlertController+CoordinatorData.swift
//  MdEditor
//
//  Created by Egor Ledkov on 28.06.2023.
//

import UIKit

extension UIAlertController {
	
	convenience init(coordinatorData: CoordinatorAlertModel) {
		self.init(title: coordinatorData.title, message: coordinatorData.message, preferredStyle: .alert)
		coordinatorData.buttons
			.map { button in
				let alertAction: UIAlertAction
				switch button.style {
				case .def:
					alertAction = UIAlertAction(title: button.title, style: .default) { _ in
						guard let newValue = self.textFields?.first?.text else {
							button.action?()
							return
						}
						guard !newValue.isEmpty else {
							button.action?()
							return
						}
						button.textAction?(newValue)
					}
				case .cancel:
					alertAction = UIAlertAction(title: button.title, style: .cancel)
				case .destructive:
					alertAction = UIAlertAction(title: button.title, style: .destructive) { _ in button.action?() }
				}
				
				return alertAction
			}
			.forEach { alertAction in
				self.addAction(alertAction)
			}
		
		coordinatorData.textFields?
			.forEach { textFieldModel in
				self.addTextField { textField in
					textField.placeholder = textFieldModel.placeHolder
				}
			}
	}
}
