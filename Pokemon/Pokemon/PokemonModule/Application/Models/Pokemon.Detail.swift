//
//  Pokemon.Detail.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 22.01.2024.
//

import UIKit

extension Pokemon {

    /// Модель детальной информации о покемоне
    struct Detail: Codable {
        /// Имя покемона
        let name: String
        /// `Sprites`
        let sprites: Sprites
        /// Характеристики покемона
        let stats: [Stat]
    }

    /// Модифицированная модель детальной информации для отображения
    struct DetailToDisplay: Codable {
        /// Имя покемона
        let name: String
        /// `Sprites`
        let sprites: [Sprite]
        /// Характеристики покемона
        let stats: [Stat]

        /// Инициализатор
        /// - Parameter detail: Базовая модель детальной информации о покемоне
        init(from detail: Pokemon.Detail) {
            name = detail.name
            sprites = detail.sprites.transformToSpritesArray()
            stats = detail.stats
        }
    }

    /// `Sprites`
    struct Sprites: Codable {
        /// `backDefault`
        let backDefault: String?
        /// `backFemale`
        let backFemale: String?
        /// `backShiny`
        let backShiny: String?
        /// `backShinyFemale`
        let backShinyFemale: String?
        /// `frontDefault`
        let frontDefault: String?
        /// `frontFemale`
        let frontFemale: String?
        /// `frontShiny`
        let frontShiny: String?
        /// `frontShinyFemale`
        let frontShinyFemale: String?

        /// Представление в виде словаря
        var dictionaryRepresentation: [String: String] {
            ["Back Default": backDefault,
             "Back Female": backFemale,
             "Back Shiny": backShiny,
             "Back Shiny Female": backShinyFemale,
             "Front Default": frontDefault,
             "Front Female": frontFemale,
             "Front Shiny": frontShiny,
             "Front Shiny Female": frontShinyFemale].compactMapValues { $0 }
        }

        /// Трансформировать в коллекцию
        /// - Returns: Массив `Sprite`
        func transformToSpritesArray() -> [Sprite] {
            dictionaryRepresentation.map { (key, value) in
                Sprite(name: key, url: value)
            }
        }

        /// Ключи для декодирования
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backFemale = "back_female"
            case backShiny = "back_shiny"
            case backShinyFemale = "back_shiny_female"
            case frontDefault = "front_default"
            case frontFemale = "front_female"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
        }
    }

    /// `Sprite`
    struct Sprite: Codable {
        /// Название
        let name: String
        /// Ссылка на изображение
        let url: String
        /// Изображение
        var image: UIImage?
        
        /// Ключи для декодирования
        enum CodingKeys: String, CodingKey {
            case name
            case url
        }
    }

    /// Характеристика
    struct Stat: Codable {
        /// Базовая характеристика
        let baseStat: Int
        /// Усиление
        let effort: Int
        /// Описание характеристики
        var statDescr: StatDescr
        
        /// Ключи для декодирования
        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case effort
            case statDescr = "stat"
        }
    }

    /// Описание характеристики
    struct StatDescr: Codable {
        /// Название характеристики
        let name: String
        /// Ссылка на изображение
        let url: String
        /// Изображение
        var image: UIImage?

        /// Ключи для декодирования
        enum CodingKeys: String, CodingKey {
            case name
            case url
        }
    }
}
