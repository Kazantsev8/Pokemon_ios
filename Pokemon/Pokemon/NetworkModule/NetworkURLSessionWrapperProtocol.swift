//
//  NetworkURLSessionWrapperProtocol.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Combine
import Foundation

/// Протокол взаимодействия к оберткой над `URLSession`
protocol NetworkURLSessionWrapperProtocol {

    /// Сделать запрос по `Endpoint`
    /// - Parameter endpoint: Модель запроса
    /// - Returns: Результат запроса
    func loadData(with endpoint: Network.Endpoint) async throws -> (Data, URLResponse)

    /// Сделать запрос по `URL`
    /// - Parameter url: Ссылка на источник
    /// - Returns: Результат запроса
    func loadData(with url: URL?) async throws -> (Data, URLResponse)
}
