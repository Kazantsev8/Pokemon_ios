//
//  Pokemon.ObtainListUseCase.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Combine

extension Pokemon {

    /// Бизнес-сценарий получения списка покемонов
    final class ObtainListUseCase: AsyncThrowableUseCase<Void, [Pokemon.Model]> {

        private let repository: PokemonRepositoryProtocol

        /// Инициализация
        /// - Parameter repository: Репозиторий функционала покемонов
        init(repository: PokemonRepositoryProtocol) {
            self.repository = repository
        }

        override func execute(_ query: Void) async throws -> [Pokemon.Model] {
            try await repository.obtainPokemonList()
        }
    }
}
