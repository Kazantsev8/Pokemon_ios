//
//  Network.Service.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Combine
import Foundation

extension Pokemon.Network {

    /// Сетевая служба функционала покемонов
    final class Service {

        private let urlSessionWrapper: NetworkURLSessionWrapperProtocol

        /// Инициализатор
        /// - Parameter urlSessionWrapper: Сетевой модуль приложения
        init(urlSessionWrapper: NetworkURLSessionWrapperProtocol) {
            self.urlSessionWrapper = urlSessionWrapper
        }
    }
}

// MARK: - PokemonNetworkServiceProtocol

extension Pokemon.Network.Service: PokemonNetworkServiceProtocol {

    func loadPokemonList() async throws -> Data {
        var response: (Data, URLResponse)
        do {
            response = try await urlSessionWrapper.loadData(with: .pokemon)
            return response.0
        } catch let error as Network.Error {
            throw handle(error: error)
        }
    }

    func loadPokemonDetail(id: Int) async throws -> Data {
        var response: (Data, URLResponse)
        do {
            response = try await urlSessionWrapper.loadData(with: .createPokemonDetail(id: id))
            return response.0
        } catch let error as Network.Error {
            throw handle(error: error)
        }
    }

    func loadData(url: String) async throws -> Data {
        guard let url = URL(string: url) else { throw Network.Error.invalidEndpoint }
        var response: (Data, URLResponse)
        do {
            response = try await urlSessionWrapper.loadData(with: url)
            return response.0
        } catch let error as Network.Error {
            throw handle(error: error)
        }
    }
}

// MARK: - Private

private extension Pokemon.Network.Service {

    func handle(error: Network.Error) -> Pokemon.Network.Error {
        switch error {
        case .invalidEndpoint:
            return .invalidEndpoint
        case .urlSessionError(let error):
            return .urlSession(error)
        }
    }
}
