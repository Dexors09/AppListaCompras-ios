//
//  FormCardView.swift
//  ListaCompras
//
//  Created by Osvaldo González on 04/11/25.
//  Refactored: Eliminada lógica de negocio, delegada al ViewModel
//

import SwiftUI

/// Vista de formulario
struct FormCardView: View {
    
    @Environment(\.appTheme) private var theme
    @Binding var nombre: String
    @Binding var cantidad: String
    @Binding var precio: String
    @Binding var vm: ListaComprasViewModel?
    
    // Control de foco de los campos
    enum Field: Hashable {
        case nombre, cantidad, precio
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        
        VStack {
            HStack{
                VStack(alignment: .leading){
                    Text("Articulo")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("Ej: Arroz", text: $nombre)
                        .focused($focusedField, equals: .nombre)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .cantidad
                        }
                    
                }
                .padding(8)
                
                VStack(alignment: .center){
                    Text("Cant.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("1", text: $cantidad)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .cantidad)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .precio
                        }
                }
                .padding(8)
                
                VStack(alignment: .center){
                    Text("Precio")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("9.99", text: $precio)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .precio)
                        .submitLabel(.done)
                        .onSubmit {
                            agregarItem()
                            focusedField = nil // Cierra teclado
                        }
                }
                .padding(8)
            }
            
            Divider()
            HStack{
                Text("Subtotal")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Subtotal: \(calcularSubtotal(), specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            
            
            Button {
                
                focusedField = nil // Cierra teclado
                agregarItem()
                
            } label: {
                Label("Agregar a la lista", systemImage: "cart.badge.plus")
                    .padding(.vertical, 8)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: theme.cornerRadius)
                            .fill(theme.primaryColor)
                    )
                    .foregroundColor(theme.textPrimary)
            }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: theme.cornerRadius, style: .continuous)
                .fill(theme.textSecondary.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: theme.cornerRadius)
                        .stroke(theme.textPrimary.opacity(0.05), lineWidth: 1)
                )
        )
        .padding(.horizontal, theme.horizontalPadding)
            // 👇 Toolbar sobre el teclado
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                    // Botones dinámicos según el campo activo
                switch focusedField {
                    case .cantidad:
                        Button("Siguiente") { focusedField = .precio }
                    case .precio:
                        Button("Agregar") {
                            focusedField = nil // Cierra teclado
                            agregarItem()
                        }
                    default:
                        EmptyView()
                }
            }
        }
    }
    
    private func calcularSubtotal() -> Double {
        let cant = Int(cantidad) ?? 0
        let prec = Double(precio) ?? 0.0
        return Double(cant) * prec
    }
    
        // Agrega el artículo a la lista
    private func agregarItem() {
        guard !nombre.isEmpty,
              let cant = Int(cantidad),
              let prec = Double(precio) else { return }
        
        vm?.addArticulo(nombre: nombre, cantidad: cant, precio: prec)
        
            // Limpiar campos
        nombre = ""
        cantidad = ""
        precio = ""
    }
}
