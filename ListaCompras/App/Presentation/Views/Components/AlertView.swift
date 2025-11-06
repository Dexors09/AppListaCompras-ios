//
//  AlertView.swift
//  ListaCompras
//
//  Created by Osvaldo González on 04/11/25.
//

import SwiftUI

struct AlertView: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let confirmText: String
    let confirmAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented) {
                Button("Cancelar", role: .cancel) {}
                Button(confirmText, role: .destructive) {
                    confirmAction()
                }
            } message: {
                Text(message)
            }
    }
}

extension View {
    func genericAlert(
        isPresented: Binding<Bool>,
        title: String = "¡Advertencia!",
        message: String,
        confirmText: String = "Eliminar",
        confirmAction: @escaping () -> Void
    ) -> some View {
        self.modifier(
            AlertView(
                isPresented: isPresented,
                title: title,
                message: message,
                confirmText: confirmText,
                confirmAction: confirmAction
            )
        )
    }
}
