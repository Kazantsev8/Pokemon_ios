//
//  PokemonRepositoryProtocol.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 23.01.2024.
//

import UIKit

/// Проткол репозитория функционала покемонов
protocol PokemonRepositoryProtocol {

    /// Получить список покемонов
    /// - Returns: Список моделей покемонов
    func obtainPokemonList() async throws -> [Pokemon.Model]

    /// Получить детальную информацию о покемоне
    /// - Parameter id: Номер покемона
    /// - Returns: Модель детальной информации о покемоне для отображения
    func obtainPokemonDetail(id: Int) async throws -> Pokemon.DetailToDisplay

    /// Получить изображение по ссылке
    /// - Parameter url: Ссылка на изображение
    /// - Returns: Изображение
    func obtainImage(for url: String) async throws -> UIImage
}
