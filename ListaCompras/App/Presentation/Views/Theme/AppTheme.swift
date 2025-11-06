//
//  AppTheme.swift
//  ListaCompras
//
//  Created by Osvaldo González on 03/11/25.

import SwiftUI

/// Tema de la aplicación
struct AppTheme {
    // Spacing & Sizes
    let cornerRadius: CGFloat
    let cardPadding: CGFloat
    let horizontalPadding: CGFloat
    
    // Colors
    let cardBackground: Color
    let primaryColor: Color
    let dangerColor: Color
    let warningColor: Color
    let safeColor: Color
    let textPrimary: Color
    let textSecondary: Color
    
    /// Tema por defecto
    static let `default` = AppTheme(
        cornerRadius: 10,
        cardPadding: 20,
        horizontalPadding: 16,
        cardBackground: Color(red: 27/255, green: 38/255, blue: 49/255).opacity(0.9),
        primaryColor: .blue,
        dangerColor: .red,
        warningColor: .orange,
        safeColor: .blue,
        textPrimary: .white,
        textSecondary: .gray
    )
    
    /// Obtiene el color según el estado del presupuesto
    func colorForBudgetStatus(_ status: BudgetCalculationService.BudgetStatus) -> Color {
        switch status {
        case .safe: return safeColor
        case .warning: return warningColor
        case .exceeded: return dangerColor
        }
    }
}

// MARK: - Environment Key

/// Environment key para inyectar el tema
private struct AppThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme.default
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {
    /// Inyecta el tema en el environment
    func appTheme(_ theme: AppTheme) -> some View {
        environment(\.appTheme, theme)
    }
}
