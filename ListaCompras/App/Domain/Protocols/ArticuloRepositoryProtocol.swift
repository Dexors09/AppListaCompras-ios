//
//  ArticuloRepositoryProtocol.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// Protocolo que define las operaciones del repositorio
protocol ArticuloRepositoryProtocol {
    func fetchAll() throws -> [ArticuloEntity]
    func add(_ articulo: ArticuloEntity) throws
    func remove(_ articulo: ArticuloEntity) throws
    func removeAll() throws
    func save() throws
}
