//
//  UIView+Extensions.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit

extension UIView {
	
	/// Возвращает имя класса для использования его при регистрации ячеек.
	static var identifier: String {
		return String(describing: self)
	}
	
	/// Добавляет на view массив subviews.
	/// - Parameter views: массив subviews, которые необходимо добавить на view
	func addSubviews(_ views: [UIView]) {
		views.forEach { addSubview($0) }
	}
}
