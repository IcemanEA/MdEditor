//
//  ICoordinatorFinishDelegate.swift
//  MdEditor
//
//  Created by Egor Ledkov on 07.10.2023.
//  Copyright © 2023 Ledkov Team. All rights reserved.
//

import Foundation

/// Делегат для выполнения кода после окончания Flow данного координатора.
protocol ICoordinatorFinishDelegate {
	
	/// Выполнение кода после завершения Flow координатора.
	/// - Parameter coordinator: координатор
	func didFinish(_ coordinator: any ICoordinator)
}
