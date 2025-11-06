//
//  BudgetCalculationService.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// Servicio de cálculo de presupuesto
class BudgetCalculationService {
    enum BudgetStatus {
        case safe
        case warning
        case exceeded
    }
    
    func calculateStatus(total: Double, budget: Double) -> BudgetStatus {
        guard budget > 0 else { return .safe }
        
        let difference = budget - total
        
        if difference <= 0 {
            return .exceeded
        } else if difference <= budget * 0.4 {
            return .warning
        } else {
            return .safe
        }
    }
    
    func getProgress(total: Double, budget: Double) -> Double {
        guard budget > 0 else { return 0 }
        return min(total / budget, 1.0)
    }
}