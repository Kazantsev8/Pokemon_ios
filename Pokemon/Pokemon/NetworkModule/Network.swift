//
//  Network.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Foundation

typealias NetworkResponse = (Data, URLResponse)

/// Namespace для сетевого модуля
enum Network {

    /// Ошибки сетевого модуля
    enum Error: Swift.Error {

        /// Некорректная модель запроса/источник
        case invalidEndpoint

        /// Ошибки `URLSession`
        case urlSessionError(Swift.Error)
    }

    /// Endpoint для запроса в сеть
    struct Endpoint {

        private let baseUrl: String

        private let path: String

        private let queryItmes: [URLQueryItem]

        /// Конечный вид URL для сетевого запроса
        var url: URL? {
            var components = URLComponents(string: baseUrl)
            components?.path = path
            components?.queryItems = queryItmes

            return components?.url
        }
    }
}

extension Network.Endpoint {

    private static var pokemonBase: String {
        return "https://pokeapi.co"
    }

    /// Сформированный endpoint для запроса за списком покемонов
    static var pokemon: Network.Endpoint {
        Network.Endpoint(baseUrl: pokemonBase,
                         path: "/api/v2/pokemon",
                         queryItmes: [])
    }

    /// Создать запрос за детальной информацией о покемоне
    /// - Parameter id: Номер покемона
    /// - Returns: Сформированный endpoint за информацией о покемоне
    static func createPokemonDetail(id: Int) -> Network.Endpoint {
        Network.Endpoint(baseUrl: pokemonBase,
                         path: "/api/v2/pokemon/" + "\(id)",
                         queryItmes: [])
    }
}
