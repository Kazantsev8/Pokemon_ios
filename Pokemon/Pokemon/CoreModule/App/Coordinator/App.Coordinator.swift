//
//  AppCoordinator.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 20.01.2024.
//

import UIKit

extension App {

    /// Главный координатор приложения
    final class Coordinator {

        private let factory: AppCoordinatorFactoryProtocol
        private var pokemonCoordinator: PokemonCoordinatorProtocol?

        /// Инициализация
        /// - Parameters:
        ///   - factory: Фабрика координаторов сценариев
        init(factory: AppCoordinatorFactoryProtocol) {
            self.factory = factory
        }
    }
}

// MARK: - AppCoordinatorProtocol

extension App.Coordinator: AppCoordinatorProtocol {

    func startApplication() {
        pokemonCoordinator = factory.createPokemonListCoordinator()
        pokemonCoordinator?.start()
    }
}
