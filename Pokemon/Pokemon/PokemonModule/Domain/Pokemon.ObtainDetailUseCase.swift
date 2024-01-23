//
//  Pokemon.ObtainDetailUseCase.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 23.01.2024.
//

extension Pokemon {

    /// Бизнес-сценарий получения детальной информации о покемоне
    final class ObtainDetailUseCase: AsyncThrowableUseCase<Int, Pokemon.DetailToDisplay> {

        private let repository: PokemonRepositoryProtocol

        /// Инициализатор
        /// - Parameter repository: Репозиторий функционала покемонов
        init(repository: PokemonRepositoryProtocol) {
            self.repository = repository
        }

        override func execute(_ query: Int) async throws -> Pokemon.DetailToDisplay {
            try await repository.obtainPokemonDetail(id: query)
        }
    }
}
