//
//  UITableView+RegisterCellsHelper.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit

extension UITableView {
	/// Регистрирует ячейку в таблице.
	/// - Parameter cell: тип (класс) ячейки, которую необходимо зарегистрировать
	func register<T: UITableViewCell>(cell: T.Type) {
		register(T.self, forCellReuseIdentifier: T.identifier)
	}
	
	/// Создает ячейку из очереди по indexPath.
	/// - Parameter indexPath: indexPath для ячейки
	/// - Returns: ячейка указанного типа (класса)
	func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
		// swiftlint:disable:next force_cast
		return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
	}
}
