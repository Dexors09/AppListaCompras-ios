//
//  ArticuloEditView.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import SwiftUI
import SwiftData

    /// Vista de edición que usa @Bindable para modificación automática
struct ArticuloEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query private var articulos: [Articulo]
    
    let articuloId: UUID
    
        //obtener el artículo específico
    private var articulo: Articulo? {
        articulos.first { $0.id == articuloId }
    }
    
    var body: some View {
        NavigationStack {
            if let articulo = articulo {
                ArticuloEditForm(articulo: articulo)
                    .navigationTitle("Editar Artículo")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Listo") {
                                dismiss()
                            }
                        }
                    }
            } else {
                ContentUnavailableView(
                    "Artículo no encontrado",
                    systemImage: "exclamationmark.triangle",
                    description: Text("No se pudo cargar el artículo")
                )
            }
        }
    }
}

    /// Formulario de edición para usar @Bindable
private struct ArticuloEditForm: View {
    @Bindable var articulo: Articulo
    
    var body: some View {
        Form {
            Section("Información del Artículo") {
                TextField("Nombre", text: $articulo.nombre)
                
                Stepper("Cantidad: \(articulo.cantidad)", value: $articulo.cantidad, in: 1...99)
                
                HStack {
                    Text("Precio")
                    Spacer()
                    TextField("Precio", value: $articulo.precio, format: .currency(code: "MXN"))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section("Resumen") {
                HStack {
                    Text("Subtotal")
                    Spacer()
                    Text(articulo.subtotal, format: .currency(code: "MXN"))
                        .foregroundStyle(.blue)
                        .bold()
                }
            }
        }
    }
}
