//
//  UICollectionViewCell+Preview.swift
//  MdEditor
//
//  Created by Egor Ledkov on 28.06.2023.
//

import UIKit
import SwiftUI

extension UICollectionViewCell {	
	struct Preview: UIViewRepresentable {
		typealias UIViewType = UICollectionViewCell
		
		let viewCell: UICollectionViewCell
		
		func makeUIView(context: Context) -> UICollectionViewCell {
			viewCell
		}
		
		func updateUIView(_ uiView: UICollectionViewCell, context: Context) {}
	}
	
	func preview() -> some View {
		Preview(viewCell: self)
	}
}
