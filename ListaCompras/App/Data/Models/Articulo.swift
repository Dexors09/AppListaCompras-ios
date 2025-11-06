//
//  Articulo.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// Modelo de persistencia para SwiftData
@Model
class Articulo {
    @Attribute(.unique) var id: UUID
    var nombre: String
    var cantidad: Int
    var precio: Double

    var subtotal: Double {
        Double(cantidad) * precio
    }

    init(id: UUID = UUID(), nombre: String, cantidad: Int, precio: Double) {
        self.id = id
        self.nombre = nombre
        self.cantidad = cantidad
        self.precio = precio
    }
    
    /// Mapper: Convierte modelo de persistencia a entidad de dominio
    func toEntity() -> ArticuloEntity {
        ArticuloEntity(
            id: id,
            nombre: nombre,
            cantidad: cantidad,
            precio: precio
        )
    }
    
    /// Mapper: Crea modelo de persistencia desde entidad de dominio
    static func fromEntity(_ entity: ArticuloEntity) -> Articulo {
        Articulo(
            id: entity.id,
            nombre: entity.nombre,
            cantidad: entity.cantidad,
            precio: entity.precio
        )
    }
}