//
//  FileManagerCoordinator.swift
//  MdEditor
//
//  Created by Egor Ledkov on 07.10.2023.
//  Copyright © 2023 Ledkov Team. All rights reserved.
//

import UIKit

protocol IFileManagerCoordinator: ICoordinator {
	func showOpenDocScene(dir: URL?)
	func showEditScene(path: URL?)
	func showPreviewScene(path: URL?)
}

final class FileManagerCoordinator: IFileManagerCoordinator {
	var flow: Flow { .fileManager(path: nil) }
	
	var finishDelegate: ICoordinatorFinishDelegate?

	var navigationController: UINavigationController

	var childCoordinators: [any ICoordinator]

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		
		self.childCoordinators = []
	}
	
	deinit {
		childCoordinators.removeAll()
		// swiftlint:disable:next print_using
		print("FileManagerCoordinator deinit")
	}

	func start(_ flow: Flow) {
		if case let .fileManager(dir) = flow {
			if let dir, dir.isFileURL {
				showEditScene(path: dir)
			} else {
				showOpenDocScene(dir: dir)
			}
		} else {
			finish()
		}
	}
	
	func showOpenDocScene(dir: URL?) {
		let request = OpenDocModels.Request(directoryPath: dir)
		let openDocController = OpenDocAssembler().assembly(request: request, coordinator: self)
		
		push(openDocController)
	}
	
	func showEditScene(path: URL?) {
		// swiftlint:disable:next print_using
		print("Открыть файл \"\(String(describing: path))\"")
	}

	func showPreviewScene(path: URL?) {
	}
}

// MARK: - ICoordinatorFinishDelegate

extension FileManagerCoordinator: ICoordinatorFinishDelegate {
	func didFinish(_ coordinator: any ICoordinator) {
		childCoordinators.removeAll()
	}
}
