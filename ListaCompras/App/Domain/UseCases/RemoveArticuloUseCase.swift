//
//  RemoveArticuloUseCase.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//

import Foundation

    // Caso de uso: Eliminar artículo
class RemoveArticuloUseCase {
    private let repository: ArticuloRepositoryProtocol
    
    init(repository: ArticuloRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(_ articulo: ArticuloEntity) throws {
        try repository.remove(articulo)
    }
}
