//
//  MainCell.swift
//  MdEditor
//
//  Created by Konstantin Pimbursky on 20.04.2023.
//

import UIKit
import PinLayout
#if DEBUG
import SwiftUI
#endif

/// Ячейка для таблицы главного меню приложения.
final class MainCell: UITableViewCell {
	
	// MARK: - Private Properties
	
	private lazy var iconImageView = createIcon()
	private lazy var titleLabel = createTitle()
	
	// MARK: - Life Cycle
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .clear
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
	
	func configure(with iconName: String, _ title: String) {
		iconImageView.image = UIImage(named: iconName)
		titleLabel.text = title
	}
	
	// MARK: - Private Methods
	
	private func addSubviews() {
		contentView.addSubviews([iconImageView, titleLabel])
	}
	
	private func layout() {
		iconImageView.pin
			.vCenter()
			.left(Sizes.Padding.normal)
			.size(CGSize(width: Sizes.Icon.width, height: Sizes.Icon.height))
		titleLabel.pin
			.after(of: iconImageView)
			.marginLeft(Sizes.Padding.normal)
			.top()
			.bottom()
			.right()
	}
}

// MARK: - Create UI Components

extension MainCell {
	private func createIcon() -> UIImageView {
		let imageView = UIImageView()
		imageView.tintColor = Theme.black
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(named: "doc")
		return imageView
	}
	
	private func createTitle() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.black
		label.text = "PreviewText"
		return label
	}
}

// MARK: - PreviewProvider

#if DEBUG
struct MainCellProvider: PreviewProvider {
	static var previews: some View {
		MainCell()
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
