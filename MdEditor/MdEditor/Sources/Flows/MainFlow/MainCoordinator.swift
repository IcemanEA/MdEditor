//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Egor Ledkov on 07.10.2023.
//  Copyright © 2023 Ledkov Team. All rights reserved.
//

import UIKit

protocol IMainCoordinator: ICoordinator {
	func showMainScene()
	func showFileManagerFlow(path: URL?)
	func showAlert(with data: CoordinatorAlertModel)
	func showAboutScene()
}

final class MainCoordinator: IMainCoordinator {
	
	var flow: Flow { .main }
	
	var finishDelegate: ICoordinatorFinishDelegate?

	var navigationController: UINavigationController

	var childCoordinators: [any ICoordinator]

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.navigationController.setNavigationBarHidden(false, animated: true)
		
		self.childCoordinators = []
	}
	
	deinit {
		childCoordinators.removeAll()
		// swiftlint:disable:next print_using
		print("MainCoordinator deinit")
	}

	func start(_ flow: Flow) {
		switch flow {
		case .main:
			showMainScene()
		case .fileManager(let path):
			showFileManagerFlow(path: path)
		case .app:
			finish()
		}
	}
	
	func showMainScene() {
		let viewController = MainAssembler().assembly(coordinator: self)
		push(viewController)
	}

	func showFileManagerFlow(path: URL?) {
		let fileManagerCoordinator = FileManagerCoordinator(navigationController: navigationController)
		fileManagerCoordinator.finishDelegate = self
		fileManagerCoordinator.start(.fileManager(path: path))
		
		childCoordinators.append(fileManagerCoordinator)
	}
	
	func showAlert(with data: CoordinatorAlertModel) {
		let alertController = UIAlertController(coordinatorData: data)
		present(alertController)
	}
	
	func showAboutScene() {
		let viewController = AboutAssembler().assembly()
		push(viewController)
	}
}

// MARK: - ICoordinatorFinishDelegate

extension MainCoordinator: ICoordinatorFinishDelegate {
	func didFinish(_ coordinator: any ICoordinator) {
		childCoordinators.removeAll { $0.flow == coordinator.flow }
	}
}
