//
//  CoordinatorsFactory.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 20.01.2024.
//

import UIKit

extension App {

    /// Фабрика создания координаторов
    final class CoordinatorFactory {}
}

// MARK: - AppCoordinatorFactoryProtocol

extension App.CoordinatorFactory: AppCoordinatorFactoryProtocol {

    func createPokemonListCoordinator() -> PokemonCoordinatorProtocol {
        Pokemon.Coordinator()
    }
}
