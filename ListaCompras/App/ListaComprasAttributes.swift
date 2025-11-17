//
//  ListaComprasAttributes.swift
//  ListaCompras
//
//  Created by Osvaldo González on 15/11/25.
//

import ActivityKit
import Foundation

struct ListaComprasAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var total: Double
        var totalItems: Int
    }
}
