//
//  Pokemon.ListViewModel.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Combine

extension Pokemon {

    /// `ViewModel` списка покемонов
    final class ListViewModel: ObservableObject {

        /// `Published` Модели покемонов для списка
        @Published var data: [Pokemon.Model] = []

        private var cancellables: Set<AnyCancellable> = []
        private let listUseCase: AsyncThrowableUseCase<Void, [Pokemon.Model]>

        /// Инициализатор
        /// - Parameter listUseCase: Бизнес-сценарий получения списка покемонов
        init(listUseCase: AsyncThrowableUseCase<Void, [Pokemon.Model]>) {
            self.listUseCase = listUseCase
        }

        func obtainPokemonList() {
            Task { [weak self] in
                guard let self else { return }

                do {
                    let models = try await listUseCase.execute(())
                    await MainActor.run {
                        self.data = models
                    }
                } catch {
                    print("ERROR")
                }
            }
        }
    }
}

