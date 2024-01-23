//
//  Pokemon.ListResponse.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 22.01.2024.
//

import Foundation

extension Pokemon {

    /// Модель ответа по запросу за списком покемонов
    struct ListResponse: Codable {
        /// Количество
        let count: Int
        /// Ссылка для запроса за следующим списком
        let next: URL?
        /// Ссылка для запроса за предыдущим списком
        let previous: URL?
        /// Список покемонов по запросу
        let results: [Pokemon.Model]
    }
}
