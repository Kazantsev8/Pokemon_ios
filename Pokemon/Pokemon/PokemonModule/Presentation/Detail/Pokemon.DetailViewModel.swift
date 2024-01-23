//
//  Pokemon.DetailViewModel.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 22.01.2024.
//

import UIKit
import Combine

extension Pokemon {

    /// `ViewModel` экрана детальной информации по покемоне
    final class DetailViewModel: ObservableObject {

        /// `Published` Имя покемона
        @Published var name: String = ""
        /// `Published` Модели характеристик покемонов
        @Published var stats: [Pokemon.Stat] = []
        /// `Published` Модели `Sprite` покемонов
        @Published var sprites: [Pokemon.Sprite] = []

        private var cancellables: Set<AnyCancellable> = []
        private let detailUseCase: AsyncThrowableUseCase<Int, Pokemon.DetailToDisplay>
        private let imageUseCase: AsyncThrowableUseCase<String, UIImage>

        /// Инициализация
        /// - Parameters:
        ///   - detailUseCase: Бизнес-сценарий получения детальной информации
        ///   - imageUseCase: Бизнес-сценарий получения изображения
        init(detailUseCase: AsyncThrowableUseCase<Int, Pokemon.DetailToDisplay>,
             imageUseCase: AsyncThrowableUseCase<String, UIImage>) {
            self.detailUseCase = detailUseCase
            self.imageUseCase = imageUseCase
        }

        func obtainPokemonDetail(id: Int) {
            Task { [weak self] in
                guard let self else { return }
                do {
                    let model = try await detailUseCase.execute(id)
                    await MainActor.run { [weak self] in
                        guard let self else { return }
                        name = model.name
                        stats = model.stats
                        sprites = model.sprites
                    }
                } catch {
                    print("ERROR")
                }
            }
        }

        func loadImage(url: String) {
            Task { [weak self] in
                guard let self else { return }
                do {
                    let image = try await imageUseCase.execute(url)
                    await MainActor.run { [weak self] in
                        guard let self else { return }
                        if let index = sprites.firstIndex(where: { $0.url == url }) {
                            sprites[index].image = image
                        }
                        if let index = stats.firstIndex(where: { $0.statDescr.url == url }) {
                            stats[index].statDescr.image = image
                        }
                    }
                } catch {
                    print("ERROR")
                }
            }
        }
    }
}
