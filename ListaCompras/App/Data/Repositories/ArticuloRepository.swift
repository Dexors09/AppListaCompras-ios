//
//  ArticuloRepository.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// Implementación del repositorio usando SwiftData
class ArticuloRepository: ArticuloRepositoryProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchAll() throws -> [ArticuloEntity] {
        let descriptor = FetchDescriptor<Articulo>(
            sortBy: [SortDescriptor(\.nombre, order: .forward)]
        )
        let articulos = try context.fetch(descriptor)
        return articulos.map { $0.toEntity() }
    }
    
    func add(_ articulo: ArticuloEntity) throws {
        let model = Articulo.fromEntity(articulo)
        context.insert(model)
        try save()
    }
    
    func remove(_ articulo: ArticuloEntity) throws {
        let articuloId = articulo.id
        let descriptor = FetchDescriptor<Articulo>(
            predicate: #Predicate { $0.id == articuloId }
        )
        if let model = try context.fetch(descriptor).first {
            context.delete(model)
            try save()
        }
    }
    
    func removeAll() throws {
        let descriptor = FetchDescriptor<Articulo>()
        let articulos = try context.fetch(descriptor)
        articulos.forEach { context.delete($0) }
        try save()
    }
    
    func save() throws {
        try context.save()
    }
}
