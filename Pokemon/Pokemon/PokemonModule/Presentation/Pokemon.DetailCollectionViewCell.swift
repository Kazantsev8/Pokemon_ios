//
//  Pokemon.DetailCollectionViewCell.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 23.01.2024.
//

import UIKit

extension Pokemon {
    
    /// Ячейка детальной информации о покемоне
    final class DetailCollectionViewCell: UICollectionViewCell {

        /// Идентификатор ячейки
        static let identifier = "DetailCollectionViewCellId"

        /// Обработчик событий ячейки
        weak var output: PokemonDetailCollectionViewCellOutput?

        private let title: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 16)
            return label
        }()

        private let subtitle: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()

        private let imageView: UIImageView = {
            let view = UIImageView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setUpLayout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func prepareForReuse() {
            super.prepareForReuse()
            title.text = nil
            subtitle.text = nil
            imageView.image = nil
        }
    }
}

// MARK: - DetailViewConfigurable

extension Pokemon.DetailCollectionViewCell: DetailViewConfigurable {

    func configure(sprite: Pokemon.Sprite) {
        title.text = sprite.name
        guard let image = sprite.image else {
            output?.loadImage(url: sprite.url)
            return
        }
        imageView.image = image
    }

    func configure(stat: Pokemon.Stat) {
        title.text = stat.statDescr.name
        subtitle.text = "Base: " + String(stat.baseStat) + " , effort: " + String(stat.effort)
        guard let image = stat.statDescr.image else {
            output?.loadImage(url: stat.statDescr.url)
            return
        }
        imageView.image = image
    }
}

// MARK: - Private

private extension Pokemon.DetailCollectionViewCell {

    func setUpLayout() {
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            title.heightAnchor.constraint(equalToConstant: 16),

            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            subtitle.heightAnchor.constraint(equalToConstant: 16),

            imageView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
