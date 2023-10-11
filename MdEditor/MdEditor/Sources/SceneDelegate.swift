//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Egor Ledkov on 19.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	// swiftlint:disable:next implicitly_unwrapped_optional
	var appCoordinator: AppCoordinator!

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		
		let navigationController = UINavigationController()
		appCoordinator = AppCoordinator(navigationController: navigationController)
		appCoordinator.start(.app)
		
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
