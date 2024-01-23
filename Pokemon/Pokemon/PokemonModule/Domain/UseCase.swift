//
//  Pokemon.UseCase.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 21.01.2024.
//

import Foundation

/// Базовый шаблон бизнес-сценария
class AsyncThrowableUseCase<Query, Response> {

    /// Выполнить
    /// - Parameter query: Параметры выполнения
    /// - Returns: Результат выполнения
    func execute(_ query: Query) async throws -> Response {
        fatalError("Must be overriden")
    }
}
