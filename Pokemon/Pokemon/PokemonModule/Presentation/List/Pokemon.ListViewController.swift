//
//  ViewController.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 20.01.2024.
//

import UIKit
import Combine

extension Pokemon {

    /// Контроллер списка покемонов
    final class ListViewController: UIViewController {

        /// Обработчик событий контроллера
        weak var output: PokemonListViewControllerOutput?

        private let viewModel: Pokemon.ListViewModel

        private let tableView: UITableView = {
            let view = UITableView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        private var cancellables: Set<AnyCancellable> = []

        /// Инициализатор
        /// - Parameter viewModel: ViewModel списка покемонов
        init(viewModel: Pokemon.ListViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            setUpSubviews()
            setUpConstraints()
            setUpTableView()
            binding()
        }
    }
}

// MARK: - UITableViewDataSource

extension Pokemon.ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = viewModel.data[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
}

// MARK: - UITableViewDelegate

extension Pokemon.ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = viewModel.data[indexPath.row]
        guard let id = pokemon.id else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        output?.openDetail(for: id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private

private extension Pokemon.ListViewController {

    func setUpSubviews() {
        view.addSubview(tableView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setUpTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.delegate = self
    }

    func binding() {
        viewModel.$data
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
        viewModel.obtainPokemonList()
    }
}
