//
//  AppCoordinatorFactoryProtocol.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 20.01.2024.
//

/// Протокол фабрики координаторов
protocol AppCoordinatorFactoryProtocol {

    /// Создать координатор сценария отображения списка покемонов
    func createPokemonListCoordinator() -> PokemonCoordinatorProtocol
}
