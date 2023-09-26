//
//  AboutWorker.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Протокол воркера для AboutScene.
protocol IAboutWorker {
	/// Получение данных о приложении.
	/// - Returns: Данные типа String.
	func fetchAboutData() -> String
}

/// Воркер для AboutScene.
final class AboutWorker: IAboutWorker {

	// MARK: - Internal Methods
	
	func fetchAboutData() -> String {
		guard let path = Bundle.main.path(forResource: L10n.About.file, ofType: "md") else {
			return L10n.Error.aboutScene
		}
		do {
			let text = try String(contentsOfFile: path, encoding: .utf8)
			return text
		} catch {
			return L10n.Error.open + L10n.Error.aboutScene
		}
	}
}
