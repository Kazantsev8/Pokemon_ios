//
//  PokemonDetailCollectionViewCell.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 23.01.2024.
//

/// Сущность, реагирующая на события ячейки детальной информации
protocol PokemonDetailCollectionViewCellOutput: AnyObject {

    /// Загрузить изображения
    /// - Parameter url: Ссылка на изображение
    func loadImage(url: String)
}
