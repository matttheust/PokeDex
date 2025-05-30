//
//  PokemonDetailViewModel.swift
//  PokeDex
//
//  Created by Matheus  Torres on 26/05/25.
//

import SwiftUI
import Combine // Importante para  ObservableObject e @Published - ESTUDAR ISSO

// MARK: - ViewModel da Tela de Detalhes
@MainActor
class PokemonDetailViewModel: ObservableObject {

    // MARK: - Propriedades Publicadas
    // A View observará estas propriedades para se atualizar.
    @Published var pokemonDetails: PokemonFullDetails? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // MARK: - Propriedades Privadas
    private let detailApiService: DetailAPIService
    private let pokemonId: Int

    // MARK: - Inicializador
    init(pokemonId: Int, detailApiService: DetailAPIService = DetailAPIService()) {
        self.pokemonId = pokemonId
        self.detailApiService = detailApiService

        carregarDetalhes()
    }

    // MARK: - Métodos Públicos
    /// Carrega os detalhes completos do Pokémon.
    func carregarDetalhes() {
        self.isLoading = true
        self.errorMessage = nil

        Task {
            do {
                let details = try await detailApiService.fetchPokemonDetails(for: self.pokemonId)
                self.pokemonDetails = details
            } catch let serviceError as DetailAPIServiceError {
                // Mapeia erros
                switch serviceError {
                case .urlInvalida:
                    self.errorMessage = "Erro interno: URL inválida para buscar detalhes."
                case .falhaNaRede(let underlyingError):
                    self.errorMessage = "Falha na conexão ao buscar detalhes: \(underlyingError.localizedDescription)"
                case .falhaNaDecodificacao(let underlyingError):
                    self.errorMessage = "Erro ao processar dados do Pokémon: \(underlyingError.localizedDescription)"
                case .dadosNaoEncontrados:
                    self.errorMessage = "Não foi possível encontrar todos os dados para este Pokémon."
                case .especieNaoEncontrada:
                    self.errorMessage = "Não foi possível carregar a descrição deste Pokémon."
                }
            } catch {
                // Trata outros erros inesperados.
                self.errorMessage = "Ocorreu um erro inesperado ao buscar detalhes: \(error.localizedDescription)"
            }
            self.isLoading = false
        }
    }
}
