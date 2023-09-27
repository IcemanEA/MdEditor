//
//  UICollectionView+RegisterItemsHelper.swift
//  MdEditor
//
//  Created by Egor Ledkov on 28.06.2023.
//

import UIKit

extension UICollectionView {
	/// Регистрирует элемент в коллекции.
	/// - Parameter cell: тип (класс) ячейки, которую необходимо зарегистрировать
	func register<T: UICollectionViewCell>(cell: T.Type) {
		register(T.self, forCellWithReuseIdentifier: T.identifier)
	}
	
	/// Создает ячейку из очереди по indexPath.
	/// - Parameter indexPath: indexPath для ячейки
	/// - Returns: ячейка указанного типа (класса)
	func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
		// swiftlint:disable:next force_cast
		dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
	}
}
