//
//  ClearListaUseCase.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// Caso de uso: Limpiar lista completa
class ClearListaUseCase {
    private let repository: ArticuloRepositoryProtocol
    
    init(repository: ArticuloRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws {
        try repository.removeAll()
    }
}