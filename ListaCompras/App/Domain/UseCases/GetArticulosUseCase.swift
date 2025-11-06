//
//  GetArticulosUseCase.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// Caso de uso: Obtener todos los artículos
class GetArticulosUseCase {
    private let repository: ArticuloRepositoryProtocol
    
    init(repository: ArticuloRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> [ArticuloEntity] {
        try repository.fetchAll()
    }
}