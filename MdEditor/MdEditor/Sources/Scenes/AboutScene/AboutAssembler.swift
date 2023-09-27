//
//  AboutAssembler.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit

/// Сборщик экрана AboutScene.
final class AboutAssembler {
	
	// MARK: - Internal Methods
	
	/// Сборка экрана AboutScene.
	func assembly() -> UIViewController {
		let viewController = AboutViewController()

		let presenter = AboutPresenter(viewController: viewController)
		let worker = AboutWorker()
		let interactor = AboutInteractor(worker: worker, presenter: presenter)
		viewController.interactor = interactor

		return viewController
	}
}
