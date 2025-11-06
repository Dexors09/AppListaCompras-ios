//
//  ListaComprasViewModel.swift
//  ListaCompras
//
//  Created by Osvaldo González on 05/11/25.
//


import Foundation
import SwiftData

/// ViewModel
@Observable
class ListaComprasViewModel {
    // Estado
    var listaActual: [ArticuloEntity] = []
    var errorMessage: String?
    
    // Casos de uso
    private let addUseCase: AddArticuloUseCase
    private let removeUseCase: RemoveArticuloUseCase
    private let getUseCase: GetArticulosUseCase
    private let clearUseCase: ClearListaUseCase
    private let calculateTotalUseCase: CalculateTotalUseCase
    
    // Servicios
    private let validationService: ArticuloValidationService
    private let budgetService: BudgetCalculationService
    
    /// Inicializador con inyección de dependencias
    init(repository: ArticuloRepositoryProtocol) {
        self.addUseCase = AddArticuloUseCase(repository: repository)
        self.removeUseCase = RemoveArticuloUseCase(repository: repository)
        self.getUseCase = GetArticulosUseCase(repository: repository)
        self.clearUseCase = ClearListaUseCase(repository: repository)
        self.calculateTotalUseCase = CalculateTotalUseCase()
        self.validationService = ArticuloValidationService()
        self.budgetService = BudgetCalculationService()
        
        loadArticulos()
    }
    
    /// Factory method para crear con ModelContext
    static func create(with context: ModelContext) -> ListaComprasViewModel {
        let repository = ArticuloRepository(context: context)
        return ListaComprasViewModel(repository: repository)
    }
    
    // MARK: - Public Methods
    
    func addArticulo(nombre: String, cantidad: Int, precio: Double) {
        do {
            try validationService.validate(nombre: nombre, cantidad: cantidad, precio: precio)
            try addUseCase.execute(nombre: nombre, cantidad: cantidad, precio: precio)
            loadArticulos()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func removeArticulo(_ articulo: ArticuloEntity) {
        do {
            try removeUseCase.execute(articulo)
            loadArticulos()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func clearLista() {
        do {
            try clearUseCase.execute()
            loadArticulos()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func calculateTotal() -> Double {
        calculateTotalUseCase.execute(articulos: listaActual)
    }
    
    func getBudgetStatus(total: Double, budget: Double) -> BudgetCalculationService.BudgetStatus {
        budgetService.calculateStatus(total: total, budget: budget)
    }
    
    func getBudgetProgress(total: Double, budget: Double) -> Double {
        budgetService.getProgress(total: total, budget: budget)
    }
    
    //Data Refresh
    func loadArticulos() {
        do {
            listaActual = try getUseCase.execute()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            listaActual = []
        }
    }
}