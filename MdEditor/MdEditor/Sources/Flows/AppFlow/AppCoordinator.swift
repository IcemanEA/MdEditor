//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Egor Ledkov on 07.10.2023.
//  Copyright © 2023 Ledkov Team. All rights reserved.
//

import UIKit

/// Протокол общего координатора приложения
protocol IAppCoordinator: ICoordinator {
	
	/// Открываем главный сценарий.
	func showMainFlow()
}

final class AppCoordinator: IAppCoordinator {
	var flow: Flow { .app }
	
	var finishDelegate: ICoordinatorFinishDelegate?
	
	var navigationController: UINavigationController
	
	var childCoordinators: [any ICoordinator]
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.navigationController.setNavigationBarHidden(true, animated: true)
		
		self.childCoordinators = []
	}
	
	func start(_ flow: Flow) {
		showMainFlow()
	}
	
	func showMainFlow() {
		let mainCoordinator = MainCoordinator(navigationController: navigationController)
		mainCoordinator.finishDelegate = self
		mainCoordinator.start(.main)
		
		childCoordinators.append(mainCoordinator)
	}
}

// MARK: - ICoordinatorFinishDelegate

extension AppCoordinator: ICoordinatorFinishDelegate {
	func didFinish(_ coordinator: any ICoordinator) {
		childCoordinators.removeAll { $0.flow == coordinator.flow }
		
		switch coordinator.flow {
		case .main:
			navigationController.viewControllers.removeAll()

			showMainFlow()
		default:
			break
		}
	}
}
