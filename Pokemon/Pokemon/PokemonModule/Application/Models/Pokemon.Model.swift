//
//  Pokemon.ListModel.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Foundation

extension Pokemon {

    /// Модель покемона для списка покемонов
    struct Model: Codable {
        /// Имя
        let name: String
        /// Ссылка на детальную информацию
        let url: String
        /// Номер покемона
        var id: Int? {
            guard let urlComponents = URLComponents(string: url),
                  let lastPathComponent = urlComponents.path.split(separator: "/").last,
                  let id = Int(lastPathComponent) else { return nil }
            return id
        }
    }
}
