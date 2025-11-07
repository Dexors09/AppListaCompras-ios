//
//  TotalCardView.swift
//  ListaCompras
//
//  Created by Osvaldo González on 04/11/25.


import SwiftUI

/// Vista de tarjeta de total y presupuesto
struct TotalCardView: View {
    
    @Environment(\.appTheme) private var theme
    @Binding var budgetText: String
    @State private var isEditing = false
    var total: Double
    var color: Color
    
    var budget: Double {
        Double(budgetText) ?? 0
    }
    
    private var progress: Double {
        min(total / budget, 1.0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
                // Título
            HStack {
                Text("Total de Compra")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                
                HStack(spacing: 4) {
                    Text("Presupuesto")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(isEditing ? "Hecho" : "Editar")
                        .frame(width: 48, height: 16, alignment: .center)
                        .font(.system(size: 12.5))
                        .foregroundColor(theme.textPrimary.opacity(0.7))
                        .onTapGesture {
                            isEditing.toggle()
                        }
                        .padding(.vertical, 3)
                        .background(theme.primaryColor.opacity(0.55).cornerRadius(4))
  
                }
                
            }
            
                // Totales
            HStack(alignment: .firstTextBaseline) {
                Text("$\(total, specifier: "%.2f")")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(theme.textPrimary)
                Spacer()
                
                if !isEditing {
                    Text("$\(budget, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.textPrimary.opacity(0.9))
                }else{
                    TextField("$0.00", text: $budgetText)
                        .padding(.leading, 30)
                        .font(.title3)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                }
                
                
            }
            
                // Barra de progreso
            ProgressView(value: progress > 0 ? progress : 0)
                .tint(color)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .animation(.easeInOut(duration: 0.6), value: progress)
            
        }
        .padding(theme.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: theme.cornerRadius, style: .continuous)
                .fill(theme.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.cornerRadius)
                        .stroke(theme.textPrimary.opacity(0.05), lineWidth: 1)
                )
        )
        .padding(.horizontal, theme.horizontalPadding)
    }
}
