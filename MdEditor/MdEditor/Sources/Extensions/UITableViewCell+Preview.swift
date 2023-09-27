//
//  UITableViewCell+Preview.swift
//  MdEditor
//
//  Created by Egor Ledkov on 28.06.2023.
//

import UIKit
import SwiftUI

extension UITableViewCell {
	struct Preview: UIViewRepresentable {
		typealias UIViewType = UITableViewCell
		
		let viewCell: UITableViewCell
		
		func makeUIView(context: Context) -> UITableViewCell {
			viewCell
		}
		
		func updateUIView(_ uiView: UITableViewCell, context: Context) {}
	}
	
	func preview() -> some View {
		Preview(viewCell: self)
	}
}
