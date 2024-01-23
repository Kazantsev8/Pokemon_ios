//
//  NetworkServiceProtocol.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Foundation

/// Проткол сетевых запросов функционала покемонов
protocol PokemonNetworkServiceProtocol {

    /// Загрузить список покемонов
    /// - Returns: Данные по запросу
    func loadPokemonList() async throws -> Data

    /// Загрузить детальную информацию о покемоне
    /// - Parameter id: Номер покемона
    /// - Returns: Данные по запросу
    func loadPokemonDetail(id: Int) async throws -> Data

    /// Загрузить данные по `url`
    /// - Parameter url: Ссылка на источник
    /// - Returns: Данные по запросу
    func loadData(url: String) async throws -> Data
}
