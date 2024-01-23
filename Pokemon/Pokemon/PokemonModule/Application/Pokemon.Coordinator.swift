//
//  Pokemon.Coordinator.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 20.01.2024.
//

import UIKit
import Combine

extension Pokemon {
    
    /// Координатор сценария работы с покемонами
    final class Coordinator {}
}

// MARK: - PokemonListCoordinatorProtocol

extension Pokemon.Coordinator: PokemonCoordinatorProtocol {

    func start() {
        let upperNavController = UINavigationController.uppenNavController()
        let urlSessionWrapper = Network.URLSessionWrapper()
        let networkService = Pokemon.Network.Service(urlSessionWrapper: urlSessionWrapper)
        let repository = Pokemon.Repository(networkService: networkService)
        let listUseCase: AsyncThrowableUseCase<Void, [Pokemon.Model]> = Pokemon.ObtainListUseCase(repository: repository)
        let viewModel = Pokemon.ListViewModel(listUseCase: listUseCase)
        let viewController = Pokemon.ListViewController(viewModel: viewModel)
        viewController.output = self
        upperNavController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - PokemonListViewControllerOutput

extension Pokemon.Coordinator: PokemonListViewControllerOutput {

    func openDetail(for pokemonId: Int) {
        openDetailScreen(pokemonId: pokemonId)
    }
}

// MARK: - Private

private extension Pokemon.Coordinator {

    func openDetailScreen(pokemonId: Int) {
        let upperNavController = UINavigationController.uppenNavController()
        let urlSessionWrapper = Network.URLSessionWrapper()
        let networkService = Pokemon.Network.Service(urlSessionWrapper: urlSessionWrapper)
        let repository: PokemonRepositoryProtocol = Pokemon.Repository(networkService: networkService)
        let detailUseCase: AsyncThrowableUseCase<Int, Pokemon.DetailToDisplay> = Pokemon.ObtainDetailUseCase(repository: repository)
        let imageUseCase: AsyncThrowableUseCase<String, UIImage> = Pokemon.ObtainImageUseCase(repository: repository)
        let viewModel = Pokemon.DetailViewModel(detailUseCase: detailUseCase, imageUseCase: imageUseCase)
        let viewController = Pokemon.DetailViewController(pokemonId: pokemonId, viewModel: viewModel)
        upperNavController?.pushViewController(viewController, animated: true)
    }
}
