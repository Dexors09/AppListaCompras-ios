//
//  AddArticuloUseCase.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//

import Foundation

    /// Caso de uso: Agregar artículo
class AddArticuloUseCase {
    private let repository: ArticuloRepositoryProtocol
    
    init(repository: ArticuloRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(nombre: String, cantidad: Int, precio: Double) throws {
        let articulo = ArticuloEntity(
            nombre: nombre,
            cantidad: cantidad,
            precio: precio
        )
        try repository.add(articulo)
    }
}
