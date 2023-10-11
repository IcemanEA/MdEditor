//
//  AboutInteractor.swift
//  MdEditor
//
//  Created by Egor Ledkov on 01.07.2023.
//

/// Протокол интерактора AboutScene.
protocol IAboutInteractor {
	
	/// Загружает данные для AboutScene.
	func fetchAboutData()
}

final class AboutInteractor: IAboutInteractor {

	// MARK: - Private Properties
	
	private var worker: IAboutWorker
	private var presenter: IAboutPresenter?

	// MARK: - Life Cycle
	
	init(worker: IAboutWorker, presenter: IAboutPresenter) {
		self.worker = worker
		self.presenter = presenter
	}

	// MARK: - Internal Methods
	
	func fetchAboutData() {
		let result = worker.fetchAboutData()
		let response = AboutModels.Response(markdownString: result)
		
		presenter?.present(response: response)
	}
}
