//
//  UIViewController+Preview.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit
import SwiftUI

extension UIViewController {
	struct Preview: UIViewControllerRepresentable {
		let viewController: UIViewController
		
		func makeUIViewController(context: Context) -> some UIViewController {
			viewController
		}
		
		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
	}
	
	func preview( ) -> some View {
		Preview(viewController: self)
	}
}
