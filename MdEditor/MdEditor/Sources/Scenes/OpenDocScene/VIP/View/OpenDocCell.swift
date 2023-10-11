//
//  OpenDocCell.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit
import PinLayout

/// Ячейка для таблице не экрана Открыть документ.
final class OpenDocCell: UITableViewCell {
	
	// MARK: - Private Properties
	
	private lazy var iconImageView = createIcon()
	private lazy var titleLabel = createTitle()
	
	// MARK: - Life Cycle
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .clear
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	// MARK: - Internal Methods
	
	/// Конфигурирует ячейку.
	/// - Parameters:
	///   - icon: иконка, которую необходимо отобразить в ячейке
	///   - title: заголовок, который необходимо отобразить в ячейке
	func configure(icon: UIImage, title: String) {
		iconImageView.image = icon
		titleLabel.text = title
	}
	
	// MARK: - Private Methods
	
	private func setupUI() {
		addSubviews([iconImageView, titleLabel])
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

private extension OpenDocCell {
	func createIcon() -> UIImageView {
		let imageView = UIImageView()
		imageView.tintColor = Theme.black
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}
	
	func createTitle() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}
