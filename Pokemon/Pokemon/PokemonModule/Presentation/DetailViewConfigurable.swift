//
//  Configurable.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 23.01.2024.
//

/// Протокол конфигурации экрана детальной информации
protocol DetailViewConfigurable {

    /// Сконфигурировать ячейку таблицы `Sprites`
    /// - Parameter sprite: Модель `Sprite`
    func configure(sprite: Pokemon.Sprite)

    /// Сконфигурировать ячейку таблицы характеристик
    /// - Parameter stat: Модель характеристик покемона
    func configure(stat: Pokemon.Stat)
}
