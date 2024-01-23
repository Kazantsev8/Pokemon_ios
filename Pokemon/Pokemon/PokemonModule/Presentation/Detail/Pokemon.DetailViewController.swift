//
//  Pokemon.DetailViewController.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 22.01.2024.
//

import UIKit
import Combine

extension Pokemon {

    /// Контроллер экрана детальной информации о покемоне
    final class DetailViewController: UIViewController {

        private let pokemonId: Int
        private var viewModel: Pokemon.DetailViewModel
        private var cancellables: Set<AnyCancellable> = []

        private let nameLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let spritesTable: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let table = UICollectionView(frame: .zero, collectionViewLayout: layout)
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()

        private let statsTable: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let table = UICollectionView(frame: .zero, collectionViewLayout: layout)
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()

        /// Инициализатор
        /// - Parameter pokemonId: Номер покемона
        init(pokemonId: Int,
             viewModel: Pokemon.DetailViewModel) {
            self.pokemonId = pokemonId
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setUpSubviews()
            setUpLayout()
            setUpTables()
            binding()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension Pokemon.DetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === spritesTable {
            return viewModel.sprites.count
        }
        if collectionView === statsTable {
            return viewModel.stats.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Pokemon.DetailCollectionViewCell.identifier,
                                                            for: indexPath) as? Pokemon.DetailCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                          for: indexPath)
            return cell
        }
        if cell.output == nil { cell.output = self }
        if collectionView === spritesTable {
            let sprite = viewModel.sprites[indexPath.row]
            cell.configure(sprite: sprite)
        }
        if collectionView === statsTable {
            let stat = viewModel.stats[indexPath.row]
            cell.configure(stat: stat)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension Pokemon.DetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === spritesTable {
            return CGSize(width: 180, height: 100)
        }
        if collectionView === statsTable {
            return CGSize(width: 180, height: 100)
        }
        return CGSize(width: 0, height: 0)
    }
}

// MARK: - UICollectionViewDelegate

extension Pokemon.DetailViewController: UICollectionViewDelegate {}

// MARK: - PokemonDetailCollectionViewCellOutput

extension Pokemon.DetailViewController: PokemonDetailCollectionViewCellOutput {

    func loadImage(url: String) {
        viewModel.loadImage(url: url)
    }
}
// MARK: - Private

private extension Pokemon.DetailViewController {

    func setUpSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(statsTable)
        view.addSubview(spritesTable)
    }

    func setUpLayout() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),

            statsTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            statsTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            statsTable.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            statsTable.heightAnchor.constraint(equalToConstant: 100),

            spritesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            spritesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            spritesTable.topAnchor.constraint(equalTo: statsTable.bottomAnchor, constant: 5),
            spritesTable.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setUpTables() {
        spritesTable.dataSource = self
        spritesTable.delegate = self
        spritesTable.register(Pokemon.DetailCollectionViewCell.self,
                              forCellWithReuseIdentifier: Pokemon.DetailCollectionViewCell.identifier)
        statsTable.dataSource = self
        statsTable.delegate = self
        statsTable.register(Pokemon.DetailCollectionViewCell.self,
                            forCellWithReuseIdentifier: Pokemon.DetailCollectionViewCell.identifier)
    }

    func binding() {
        viewModel.$name
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                guard let self else { return }
                self.nameLabel.text = name
            }
            .store(in: &cancellables)
        viewModel.$stats
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.statsTable.reloadData()
            }
            .store(in: &cancellables)
        viewModel.$sprites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.spritesTable.reloadData()
            }
            .store(in: &cancellables)
        viewModel.obtainPokemonDetail(id: pokemonId)
    }
}
