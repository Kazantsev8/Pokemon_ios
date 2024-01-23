//
//  Pokemon.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 20.01.2024.
//

/// Namespace для списка покемонов
enum Pokemon {

    /// Namespace для сетевого взаимодействия
    enum Network {

        /// Ошибки сетевого взаимодействия
        enum Error: Swift.Error {

            /// Некорректная модель запроса/источник
            case invalidEndpoint

            /// Ошибка `URLSession`
            case urlSession(Swift.Error)
        }
    }

    /// Namespace для слоя работы с данными
    enum Data {

        /// Ошибки слоя работы с данными
        enum Error: Swift.Error {

            /// Ошибка декодирования
            case decoding
        }
    }
}
