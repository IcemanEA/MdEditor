//
//  UIAlertController+action.swift
//  MdEditor
//
//  Created by Egor Ledkov on 28.06.2023.
//

import UIKit

extension UIAlertController {
	
	static func createAlert(withTitle title: String, andMessage message: String) -> UIAlertController {
		UIAlertController(title: title, message: message, preferredStyle: .alert)
	}
		
	func action() {
		let okAction = UIAlertAction(title: "OK", style: .default)
		addAction(okAction)
	}
		
	func action(withText placeholder: String, completion: @escaping (String) -> Void) {
		let addAlertAction = UIAlertAction(title: L10n.Alert.Button.add, style: .default) { _ in
			guard let newValue = self.textFields?.first?.text else { return }
			guard !newValue.isEmpty else { return }
			completion(newValue)
		}
		
		let cancelAction = UIAlertAction(title: L10n.Alert.Button.cancel, style: .destructive)
		
		addAction(addAlertAction)
		addAction(cancelAction)
		addTextField { textField in
			textField.placeholder = placeholder
		}
	}
}
