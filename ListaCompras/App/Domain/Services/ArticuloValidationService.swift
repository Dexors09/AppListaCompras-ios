//
//  ArticuloValidationService.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// Servicio de validación de artículos
class ArticuloValidationService {
    enum ValidationError: LocalizedError {
        case emptyName
        case invalidQuantity
        case invalidPrice
        
        var errorDescription: String? {
            switch self {
            case .emptyName: return "El nombre no puede estar vacío"
            case .invalidQuantity: return "La cantidad debe ser mayor a 0"
            case .invalidPrice: return "El precio debe ser mayor a 0"
            }
        }
    }
    
    func validate(nombre: String, cantidad: Int, precio: Double) throws {
        guard !nombre.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw ValidationError.emptyName
        }
        guard cantidad > 0 else {
            throw ValidationError.invalidQuantity
        }
        guard precio > 0 else {
            throw ValidationError.invalidPrice
        }
    }
}