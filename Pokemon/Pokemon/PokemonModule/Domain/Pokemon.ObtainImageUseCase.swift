//
//  Pokemon.ObtainImage.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 23.01.2024.
//

import UIKit

extension Pokemon {

    /// Бизнес-сценарий получения изображения
    final class ObtainImageUseCase: AsyncThrowableUseCase<String, UIImage> {

        private let repository: PokemonRepositoryProtocol

        /// Инициализатор
        /// - Parameter repository: Репозиторий функционала покемонов
        init(repository: PokemonRepositoryProtocol) {
            self.repository = repository
        }

        override func execute(_ query: String) async throws -> UIImage {
            try await repository.obtainImage(for: query)
        }
    }
}
