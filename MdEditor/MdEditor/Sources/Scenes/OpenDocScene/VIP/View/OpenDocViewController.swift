//
//  OpenDocViewController.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import UIKit
import PinLayout

/// Протокол вью контроллера экрана Открыть документ.
protocol IOpenDocViewController: UIViewController {
	
	/// Формирует UI в соответствии с viewModel.
	/// - Parameter viewModel: модель экрана для рендера
	func render(viewModel: OpenDocModels.ViewModel)
}

/// Вью контроллер экрана Открыть документ.
final class OpenDocViewController: UIViewController {
	
	// MARK: - Internal Properties
	
	var interactor: IOpenDocInteractor?
	
	// MARK: - Private Properties
	private let request: OpenDocModels.Request
	private var viewModel = OpenDocModels.ViewModel(title: "", files: [])
	
	private lazy var table: UITableView = createTable()
	
	// MARK: - Life Cycle
	
	init(request: OpenDocModels.Request) {
		self.request = request
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
		setupTable()
		addSubviews()
		layout()
		
		interactor?.fetchData(request: request)
	}
	
	// MARK: - Private Methods
	
	private func setupView() {
		title = viewModel.title
		view.backgroundColor = Theme.backgroundColor
		navigationController?.navigationBar.tintColor = Theme.black
		navigationController?.navigationBar.accessibilityIdentifier = AccessibilityIdentifier.OpenDocScene.title
	}
	
	private func setupTable() {
		table.delegate = self
		table.dataSource = self
		table.register(cell: OpenDocCell.self)
	}
	private func addSubviews() {
		view.addSubview(table)
	}
	
	private func layout() {
		table.pin
			.all(PEdgeInsets(top: Sizes.Padding.normal, left: 0, bottom: Sizes.Padding.normal, right: 0))
	}
}

// MARK: - IOpenDocViewController

extension OpenDocViewController: IOpenDocViewController {
	func render(viewModel: OpenDocModels.ViewModel) {
		self.viewModel = viewModel
		self.title = viewModel.title
		self.table.reloadData()
	}
}

// MARK: - UITableViewDataSource

extension OpenDocViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: OpenDocCell = tableView.dequeueCell(for: indexPath)
		let file = viewModel.getFile(at: indexPath)
		
		cell.configure(icon: file.type.icon, title: file.url.lastPathComponent)
		
		return cell
	}
}

// MARK: - UITableViewDelegate

extension OpenDocViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		Sizes.Large.height
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		let file = viewModel.getFile(at: indexPath)
		switch file.type {
		case .directory:
			let request = OpenDocModels.Request(directoryPath: file.url)
			interactor?.showNextOpenDocScreen(request: request)
		case .file:
			interactor?.showFile(by: file.url)
		}
	}
}

// MARK: - Create UI Components

private extension OpenDocViewController {
	func createTable() -> UITableView {
		let table = UITableView(frame: .zero, style: .plain)
		
		table.showsHorizontalScrollIndicator = false
		table.backgroundColor = .clear
		table.separatorStyle = .none
		table.translatesAutoresizingMaskIntoConstraints = false
		
		return table
	}
}
