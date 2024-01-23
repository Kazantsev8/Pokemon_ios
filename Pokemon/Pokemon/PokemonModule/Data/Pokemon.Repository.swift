//
//  Pokemon.Repository.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 23.01.2024.
//

import Foundation
import UIKit

extension Pokemon {

    /// Репозиторий функционала покемонов
    final class Repository {

        private let networkService: PokemonNetworkServiceProtocol
        private let imageCache = NSCache<NSString, UIImage>()
        
        /// Инициализатор
        /// - Parameter networkService: Сетевая служба
        init(networkService: PokemonNetworkServiceProtocol) {
            self.networkService = networkService
        }
    }
}

// MARK: - PokemonRepositoryProtocol

extension Pokemon.Repository: PokemonRepositoryProtocol {

    func obtainPokemonList() async throws -> [Pokemon.Model] {
        let result = try await networkService.loadPokemonList()
        do {
            let responseModel = try JSONDecoder().decode(Pokemon.ListResponse.self, from: result)
            return responseModel.results
        } catch {
            throw Pokemon.Data.Error.decoding
        }
    }

    func obtainPokemonDetail(id: Int) async throws -> Pokemon.DetailToDisplay {
        let result = try await networkService.loadPokemonDetail(id: id)
        do {
            let responseModel = try JSONDecoder().decode(Pokemon.Detail.self, from: result)
            let detailToDisplay = Pokemon.DetailToDisplay(from: responseModel)
            return detailToDisplay
        } catch {
            throw Pokemon.Data.Error.decoding
        }
    }

    func obtainImage(for url: String) async throws -> UIImage {
        let cacheKey = NSString(string: url)
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            return cachedImage
        }
        let result = try await networkService.loadData(url: url)
        guard let image = UIImage(data: result) else {
            throw Pokemon.Data.Error.decoding
        }
        imageCache.setObject(image, forKey: cacheKey)
        return image
    }
}
