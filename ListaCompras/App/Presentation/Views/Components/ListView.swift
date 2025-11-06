//
//  ListView.swift
//  ListaCompras
//
//  Created by Osvaldo González on 04/11/25.


import SwiftUI
import SwiftData

/// Vista de lista
struct ListView: View {
    @Binding var vm: ListaComprasViewModel
    @State private var showAlert = false
    @State private var itemToDelete: ArticuloEntity?
    @State private var showEditSheet = false
    @State private var itemToEdit: ArticuloEntity?
    
    var body: some View {
        List {
            ForEach(vm.listaActual) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.nombre)
                        Text("Cantidad: \(item.cantidad)  Precio: \(item.precio, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("$\(item.subtotal, specifier: "%.2f")")
                        .foregroundStyle(.blue)
                }
                .padding(.vertical, 4)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        itemToDelete = item
                        showAlert = true
                    } label: {
                        Label("Eliminar", systemImage: "trash")
                    }
                    .tint(.red)
                    
                    Button {
                        itemToEdit = item
                        showEditSheet = true
                    } label: {
                        Label("Editar", systemImage: "square.and.pencil")
                    }
                    .tint(.blue)
                }
            }
        }
        .genericAlert(
            isPresented: $showAlert,
            message: "¿Está seguro de eliminar?",
            confirmText: "Eliminar"
        ) {
            if let item = itemToDelete {
                vm.removeArticulo(item)
            }
        }
        .sheet(isPresented: $showEditSheet) {
            vm.loadArticulos()
        } content: {
            if let item = itemToEdit {
                ArticuloEditView(articuloId: item.id)
            }
        }
    }
}
