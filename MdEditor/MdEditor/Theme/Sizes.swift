//
//  Sizes.swift
//  MdEditor
//
//  Created by Egor Ledkov on 19.04.2023.
//

import Foundation
import PinLayout

/// Размеры UI Элементов приложения
enum Sizes {
	
	/// 6
	static let cornerRadius: CGFloat = 6
	
	/// 1
	static let borderWidth: CGFloat = 1
	
	/// 25%
	static let recentlyHeight: Percent = 25%
	
	enum Padding {
		/// 8
		static let half: CGFloat = 8
		/// 16
		static let normal: CGFloat = 16
		/// 32
		static let double: CGFloat = 32
	}
	
	/// 200x50
	enum Large {
		/// 200
		static let width: CGFloat = 200
		/// 50
		static let height: CGFloat = 50
	}
	
	/// 100x40
	enum Medium {
		/// 100
		static let width: CGFloat = 100
		/// 40
		static let height: CGFloat = 40
	}
	
	/// 80x30
	enum Small {
		/// 80
		static let width: CGFloat = 80
		/// 30
		static let height: CGFloat = 30
	}
	
	/// 20x20
	enum Icon {
		/// 20
		static let width: CGFloat = 20
		/// 20
		static let height: CGFloat = 20
	}
}
