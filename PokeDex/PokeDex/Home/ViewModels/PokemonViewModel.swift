//
//  PokemonViewModel.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import SwiftUI

// MARK: - ViewModel da Home
@MainActor
class PokemonViewModel: ObservableObject {
    // MARK: - Propriedades Publicadas
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // MARK: - Propriedades Privadas
    private let homeApiService: HomeAPIService

    // MARK: - Inicializador
    init(homeApiService: HomeAPIService = HomeAPIService()) {
        self.homeApiService = homeApiService
    }

    // MARK: - Métodos Públicos
    func carregarPokemons() {
        self.isLoading = true
        self.errorMessage = nil
        self.pokemons = []
        
        // Mapeia erros
        Task {
            do {
                let fetchedPokemons = try await homeApiService.fetchPrimeiraGeracao()
                self.pokemons = fetchedPokemons
            } catch let serviceError as HomeAPIServiceError {
                switch serviceError {
                case .urlInvalida:
                    self.errorMessage = "Erro: URL da API inválida."
                case .falhaNaRede(let underlyingError):
                    self.errorMessage = "Erro de conexão: \(underlyingError.localizedDescription)"
                case .falhaNaDecodificacao(let underlyingError):
                    self.errorMessage = "Erro ao processar dados: \(underlyingError.localizedDescription)"
                }
            } catch {
                self.errorMessage = "Ocorreu um erro: \(error.localizedDescription)"
            }
            self.isLoading = false
        }
    }
}
