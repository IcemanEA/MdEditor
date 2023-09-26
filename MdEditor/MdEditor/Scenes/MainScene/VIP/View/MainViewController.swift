//
//  MainViewController.swift
//  MdEditor
//

import UIKit
import PinLayout
#if DEBUG
import SwiftUI
#endif

/// Протокол ViewController'a главного меню.
protocol IMainViewController: UIViewController {
	/// Формирует внешний вид экрана на основе переданной модели.
	/// - Parameter viewModel: модель, на основе которой формируется UI экрана.
	func render(viewModel: MainModels.ViewModel)
}

/// Контроллер главного меню приложения.
final class MainViewController: UIViewController {
	
	// MARK: - Internal Properties
	
	var interactor: IMainInteractor?
	var router: IMainRouter?
	
	// MARK: - Private Properties
	
	private var viewModel = MainModels.ViewModel(menuItems: [], recentlyItems: [])

	private lazy var menuTable: UITableView = createMenuTable()
	private lazy var recentlyColletion: UICollectionView = createRecentlyCollection()

	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
		setupUI()
		addSubviews()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		interactor?.fetchData()
		layout()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		layout()
	}
	
	// MARK: - Private Methods
	
	private func setupView() {
		title = L10n.Main.title
		navigationController?.navigationBar.accessibilityIdentifier = AccessibilityIdentifier.MainScene.title
		view.backgroundColor = Theme.backgroundColor
	}
	
	private func setupUI() {
		menuTable.register(cell: MainCell.self)
		menuTable.delegate = self
		menuTable.dataSource = self
		
		recentlyColletion.register(cell: MainRecentlyCell.self)
		recentlyColletion.delegate = self
		recentlyColletion.dataSource = self
	}
	
	private func addSubviews() {
		view.addSubviews([recentlyColletion, menuTable])
	}
	
	private func layout() {
		let safeTop: CGFloat = view.pin.safeArea.top + Sizes.Padding.normal
		let recentlyHeight = viewModel.recentlyItems.isEmpty ? 0% : Sizes.recentlyHeight
		
		recentlyColletion.pin
			.left(Sizes.Padding.normal)
			.right(Sizes.Padding.normal)
			.top(safeTop)
			.height(recentlyHeight)
		
		menuTable.pin
			.below(of: recentlyColletion)
			.marginTop(Sizes.Padding.normal)
			.left()
			.right()
			.bottom(Sizes.Padding.normal)
	}
}

// MARK: - IMainViewController

extension MainViewController: IMainViewController {
	func render(viewModel: MainModels.ViewModel) {
		self.viewModel = viewModel
		self.menuTable.reloadData()
		self.recentlyColletion.reloadData()
	}
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.menuItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: MainCell = tableView.dequeueCell(for: indexPath)
		let item = viewModel.item(at: indexPath)
		
		cell.configure(with: item.icon, item.title)
		
		return cell
	}
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		Sizes.Large.height
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		
		let item = viewModel.item(at: indexPath)
		
		switch item.type {
		case .openDocument:
			router?.showOpenDocScreen()
		case .newDocument:
			router?.showNewDocScreen()
		case .aboutApp:
			router?.showAboutScreen()
		}
	}
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
		collectionView.deselectItem(at: indexPath, animated: true)
		
		return true
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let url = viewModel.recentlyItems[indexPath.row].url
		
		router?.showFile(url)
	}
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.recentlyItems.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: MainRecentlyCell = collectionView.dequeueCell(for: indexPath)
		let item = viewModel.recentlyItems[indexPath.row]
		
		cell.configure(item.name, with: item.previewText)
		
		return cell
	}
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let height = recentlyColletion.frame.height
		let width = height * 0.6
		
		return CGSize(width: width, height: height)
	}
}

// MARK: - Create UI Components

private extension MainViewController {
	func createMenuTable() -> UITableView {
		let table = UITableView(frame: .zero, style: .plain)
		
		table.isScrollEnabled = false
		table.showsVerticalScrollIndicator = false
		table.showsHorizontalScrollIndicator = false
		table.separatorStyle = .none
		table.backgroundColor = Theme.backgroundColor
		table.translatesAutoresizingMaskIntoConstraints = false
		
		return table
	}
	
	func createRecentlyCollection() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		
		layout.minimumLineSpacing = Sizes.Padding.normal
		layout.scrollDirection = .horizontal
		
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		collection.backgroundColor = Theme.backgroundColor
		collection.translatesAutoresizingMaskIntoConstraints = false
		
		return collection
	}
}

// MARK: - PreviewProvider

#if DEBUG
struct MainViewControllerProvider: PreviewProvider {
	static var previews: some View {
		MainViewController()
			.preview()
	}
}
#endif
