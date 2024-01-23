//
//  URLSessionWrapper.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Foundation
import Combine

extension Network {

    /// Изолирующий класс для работы с URLSession
    final class URLSessionWrapper {

        private let urlSession: URLSession
        
        /// Инициализатор
        /// - Parameter urlSession: Экземпляр URLSession
        init(urlSession: URLSession = URLSession.shared) {
            self.urlSession = urlSession
        }
    }
}

// MARK: - NetworkURLSessionWrapperProtocol

extension Network.URLSessionWrapper: NetworkURLSessionWrapperProtocol {

    func loadData(with endpoint: Network.Endpoint) async throws -> (Data, URLResponse) {
        guard let url = endpoint.url else { throw Network.Error.invalidEndpoint }
        do {
            let response = try await urlSession.data(from: url)
            return response
        } catch {
            throw Network.Error.urlSessionError(error)
        }
    }

    func loadData(with url: URL?) async throws -> (Data, URLResponse) {
        guard let url else { throw Network.Error.invalidEndpoint }
        do {
            let response = try await urlSession.data(from: url)
            return response
        } catch {
            throw Network.Error.urlSessionError(error)
        }
    }
}
