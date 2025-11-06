//
//  ContentView.swift
//  ListaCompras
//
//  Created by Osvaldo González on 23/10/25.


import SwiftUI

/// Vista principal
struct MainView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.appTheme) private var theme
    @State private var vm: ListaComprasViewModel?
    
    @State private var nombre = ""
    @State private var cantidad = ""
    @State private var precio = ""
    @State private var presupuestoText = ""
    @State private var showAlert = false
    
    // Computed properties simplificadas
    private var presupuesto: Double {
        Double(presupuestoText) ?? 0
    }
    
    private var total: Double {
        vm?.calculateTotal() ?? 0
    }
    
    private var budgetStatus: BudgetCalculationService.BudgetStatus {
        vm?.getBudgetStatus(total: total, budget: presupuesto) ?? .safe
    }
    
    private var colorTotal: Color {
        theme.colorForBudgetStatus(budgetStatus)
    }
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Registro de Compras")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, theme.horizontalPadding)
                .foregroundColor(theme.textPrimary)
            
            TotalCardView(budgetText: $presupuestoText, total: total, color: colorTotal)
            
            FormCardView(nombre: $nombre, cantidad: $cantidad, precio: $precio, vm: $vm)
            
            if let vm = vm {
                ListView(vm: .constant(vm))
            }
            
            Button {
                showAlert = true
            } label: {
                Label("Borrar lista", systemImage: "trash")
                    .padding(.vertical, 8)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: theme.cornerRadius)
                            .fill(theme.dangerColor.opacity(0.75))
                    )
                    .foregroundColor(theme.textPrimary)
            }
            .padding(.horizontal, theme.horizontalPadding)

            
        }
        .onAppear {
            let repository = ArticuloRepository(context: context)
            vm = ListaComprasViewModel(repository: repository)
        }
        .genericAlert(
            isPresented: $showAlert,
            message: "¿Está seguro de borrrar toda la lista?",
            confirmText: "Eliminar"
        ) {
            vm?.clearLista()
        }
    }
}


