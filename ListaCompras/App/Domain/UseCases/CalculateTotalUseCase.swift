//
//  CalculateTotalUseCase.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// Caso de uso: Calcular total de compra
class CalculateTotalUseCase {
    func execute(articulos: [ArticuloEntity]) -> Double {
        articulos.reduce(0) { $0 + $1.subtotal }
    }
}