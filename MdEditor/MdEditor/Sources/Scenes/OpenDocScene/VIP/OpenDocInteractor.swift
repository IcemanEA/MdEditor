//
//  OpenDocInteractor.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

import Foundation

/// Протокол интерактора для экрана Открыть документ.
protocol IOpenDocInteractor {
	
	/// Запрашивает набор файлов для отображения на экране
	/// - Parameter request: формат запроса файлов для отображения на экране
	func fetchData(request: OpenDocModels.Request)
	
	/// Открывает следующий экран Открыть документ для указанной папки.
	/// - Parameter request: запрос, который указывает папку,
	/// содержимое которой необходимо отобразить на следующем экране Открыть документ
	func showNextOpenDocScreen(request: OpenDocModels.Request)
	
	/// Открываем файл для редактирования и просмотра.
	/// - Parameter url: Ссылка на файл
	func showFile(by url: URL)
}

/// Интерактор для экрана открыть документ.
final class OpenDocInteractor: IOpenDocInteractor {
	
	// MARK: - Private Properties
	
	private var currentPath: URL?
	
	private let coordinator: IFileManagerCoordinator
	private let presenter: IOpenDocPresenter
	private let filesWorker: IOpenDocFilesWorker
	private let recentlyFilesManager: IRecentlyFilesManager
	
	// MARK: - Life Cycle
	
	init(
		coordinator: IFileManagerCoordinator,
		presenter: IOpenDocPresenter,
		filesWorker: IOpenDocFilesWorker,
		recentlyFilesManager: IRecentlyFilesManager
	) {
		self.coordinator = coordinator
		self.presenter = presenter
		self.filesWorker = filesWorker
		self.recentlyFilesManager = recentlyFilesManager
	}
	
	deinit {
		if currentPath == nil {
			coordinator.finishDelegate?.didFinish(coordinator)
		}
	}
	
	// MARK: - Internal Methods
	
	func fetchData(request: OpenDocModels.Request) {
		var files: [OpenDocModels.File] = []
		
		currentPath = request.directoryPath
		filesWorker.getFiles(atPath: request.directoryPath).forEach { file in
			let vmFile = decodeFileToViewModelFile(file)
			files.append(vmFile)
		}
		
		let title = getTitle(from: request.directoryPath)
		let response = OpenDocModels.Response(title: title, files: files)
		presenter.present(response: response)
	}
	
	func showNextOpenDocScreen(request: OpenDocModels.Request) {
		coordinator.showOpenDocScene(dir: request.directoryPath)
	}
	
	func showFile(by url: URL) {
		if let fileStrings = try? String(contentsOfFile: url.path) {
			recentlyFilesManager.addFileToStorage(url: url, previewText: fileStrings)
			coordinator.showEditScene(path: url)
		}
	}
	
	// MARK: - Private Methods
	
	private func getTitle(from path: URL?) -> String {
		guard let path else { return L10n.Localizable.OpenDoc.title }
		
		return path.lastPathComponent
	}
	
	private func decodeFileToViewModelFile(_ file: File) -> OpenDocModels.File {
		let type: OpenDocModels.FileType
		
		switch file.fileType {
		case .directory:
			type = .directory
		case .file:
			type = .file
		}
		
		let vmFile = OpenDocModels.File(
			url: file.url,
			type: type,
			name: file.url.lastPathComponent
		)
		
		return vmFile
	}
}
