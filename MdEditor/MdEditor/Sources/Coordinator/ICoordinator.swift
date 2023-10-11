//
//  ICoordinator.swift
//  MdEditor
//
//  Created by Egor Ledkov on 27.09.2023.
//  Copyright © 2023 Ledkov Team. All rights reserved.
//

import UIKit

/// Единый протокол для координаторов.
protocol ICoordinator: AnyObject {
	/// Открытый в данный момент Flow.
	var flow: Flow { get }
	
	/// Делегат для выполнения действия завершения Flow.
	var finishDelegate: ICoordinatorFinishDelegate? { get set }
	
	/// Навигатор, благодаря которому будем двигать по View (должен быть заинъекчен в каждой конкретной реализации).
	var navigationController: UINavigationController { get set }
	
	/// Дочерние коорлинаторы, которые содержат дочерние объекты (удаляются после завершения Flow).
	var childCoordinators: [any ICoordinator] { get set }
	
	/// Старт Flow данного координатора.
	func start(_ flow: Flow)
	
	/// Окончание Flow данного координатора.
	func finish()
}

extension ICoordinator {
	/// Показать  сцену в модальном окне.
	/// - Parameters:
	///   - viewController: Вью..
	///   - animated: Показать с анимацией (по умолчанию true).
	///   - completion: Выполняем код, который срабатывает после появления вью.
	func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
		self.navigationController.present(viewController, animated: animated, completion: completion)
	}
	
	/// Сворачиваем модальную вью.
	/// - Parameters:
	///   - animated: Показать с анимацией (по умолчанию true).
	///   - completion: Выполняем код, который срабатывает после сворачивания вью.
	func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
		self.navigationController.dismiss(animated: animated, completion: completion)
	}
	
	/// Показать вью в следующем экране навигатора.
	/// - Parameters:
	///   - viewController: Вью.
	///   - animated: Выполнить с анимацией (по умолчанию true).
	func push(_ viewController: UIViewController, animated: Bool = true) {
		self.navigationController.pushViewController(viewController, animated: animated)
	}
	
	/// Вернуться назад по  навигатору.
	/// - Parameters:
	///   - animated: Выполнить с анимацией (по умолчанию true).
	func pop(animated: Bool = true) {
		self.navigationController.popViewController(animated: animated)
	}
	
	/// Окончание Flow данного координатора.
	func finish() {
		childCoordinators.removeAll()
		finishDelegate?.didFinish(self)
	}
}
