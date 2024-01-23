//
//  PokemonListViewControllerOutput.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 23.01.2024.
//

/// Сущность, реагирующая на события контроллера списка покемонов
protocol PokemonListViewControllerOutput: AnyObject {

    /// Открыть экран детальной информации
    /// - Parameter pokemonId: Номер покемона
    func openDetail(for pokemonId: Int)
}
