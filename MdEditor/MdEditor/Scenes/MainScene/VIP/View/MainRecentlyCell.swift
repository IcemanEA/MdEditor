//
//  MainRecentlyCell.swift
//  MdEditor
//
//  Created by Egor Ledkov on 28.06.2023.
//

import UIKit
import PinLayout
#if DEBUG
import SwiftUI
#endif

/// Ячейка для таблицы главного меню приложения.
final class MainRecentlyCell: UICollectionViewCell {
	
	// MARK: - Private Properties
	
	private lazy var previewStackView = createPreviewStackView()
	private lazy var previewLabel = createPreviewLabel()
	private lazy var nameLabel = createName()
	
	// MARK: - Life Cycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layout()
	}
	
	// MARK: - Internal Methods
	
	func configure(_ name: String, with previewText: String) {
		self.backgroundColor = .clear
		
		previewLabel.text = previewText
		nameLabel.text = name
	}
	
	// MARK: - Private Methods
	
	private func addSubviews() {
		previewStackView.addArrangedSubview(previewLabel)
		
		contentView.addSubviews([previewStackView, nameLabel])
	}
	
	private func layout() {
		previewStackView.pin
			.top()
			.left()
			.right()
			.bottom(Sizes.Small.height)
		
		nameLabel.pin
			.below(of: previewStackView)
			.left()
			.right()
			.bottom()
			.maxHeight(Sizes.Small.height)
	}
}

// MARK: - Create UI Components

private extension MainRecentlyCell {
	func createPreviewStackView() -> UIStackView {
		let stack = UIStackView()
		
		stack.distribution = .fill
		stack.alignment = .top
		stack.backgroundColor = Theme.accentColorBackgroundColor
		
		return stack
	}
	
	func createPreviewLabel() -> UILabel {
		let label = UILabel()
		
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = Theme.black
		label.text = "PreviewText"
		label.numberOfLines = 0
		label.textAlignment = .left
		label.lineBreakMode = .byWordWrapping
		
		return label
	}
	
	func createName() -> UILabel {
		let label = UILabel()
		
		label.textColor = Theme.black
		label.text = "NameText"
		label.numberOfLines = 1
		label.textAlignment = .center
		label.minimumScaleFactor = 0.7
		
		return label
	}
}

// MARK: - PreviewProvider

#if DEBUG
struct MainRecentlyCellProvider: PreviewProvider {
	static var previews: some View {
		MainRecentlyCell()
			.preview()
			.frame(
				width: UIScreen.main.bounds.width,
				height: Sizes.Large.height,
				alignment: .center
			)
			.previewLayout(.sizeThatFits)
	}
}
#endif
