//
//  ArticuloEntity.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//

import Foundation
import SwiftData

/// Entidad de dominio
struct ArticuloEntity: Identifiable, Equatable {
    let id: UUID
    let nombre: String
    let cantidad: Int
    let precio: Double
    
    var subtotal: Double {
        Double(cantidad) * precio
    }
    
    init(id: UUID = UUID(), nombre: String, cantidad: Int, precio: Double) {
        self.id = id
        self.nombre = nombre
        self.cantidad = cantidad
        self.precio = precio
    }
}
