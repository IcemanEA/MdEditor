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
}

/// Интерактор для экрана открыть документ.
final class OpenDocInteractor: IOpenDocInteractor {
	
	// MARK: - Private Properties
	
	private let presenter: IOpenDocPresenter
	private let filesWorker: IOpenDocFilesWorker
	
	// MARK: - Life Cycle
	
	init(presenter: IOpenDocPresenter, filesWorker: IOpenDocFilesWorker) {
		self.presenter = presenter
		self.filesWorker = filesWorker
	}
	
	// MARK: - Internal Methods
	
	func fetchData(request: OpenDocModels.Request) {
		var files: [OpenDocModels.File] = []
		
		filesWorker.getFiles(atPath: request.directoryPath).forEach { file in
			let vmFile = decodeFileToViewModelFile(file)
			files.append(vmFile)
		}
		
		let title = getTitle(from: request.directoryPath)
		let response = OpenDocModels.Response(title: title, files: files)
		presenter.present(response: response)
	}
	
	// MARK: - Private Methods
	
	private func getTitle(from path: URL?) -> String {
		guard let path else { return L10n.OpenDoc.title }
		
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
