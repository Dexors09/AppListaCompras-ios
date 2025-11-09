//
//  ListaComprasApp.swift
//  ListaCompras
//
//  Created by Osvaldo González on 23/10/25.


import SwiftUI
import SwiftData

@main
struct ListaComprasApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: Articulo.self)
                .appTheme(.default) // Inyecta el tema en toda la app
                .preferredColorScheme(.dark)
        }
    }
}
