//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Egor Ledkov on 19.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let winScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: winScene)
		let mainViewController = MainAssembler().assembly()
		window.rootViewController = UINavigationController(rootViewController: mainViewController)
		window.makeKeyAndVisible()
		self.window = window
	}
}
