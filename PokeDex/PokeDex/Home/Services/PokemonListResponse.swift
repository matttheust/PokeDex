//
//  PokemonListResponse.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import Foundation

// MARK: - Estruturas Privadas para Decodificação
private struct PokemonListResponse: Decodable {
    let results: [PokemonListItem]
}

private struct PokemonListItem: Decodable {
    let name: String
    let url: String
}

// MARK: - Erros do Serviço
enum HomeAPIServiceError: Error {
    case urlInvalida
    case falhaNaRede(Error)
    case falhaNaDecodificacao(Error)
}

// MARK: - Serviço de API da Home
class HomeAPIService {
    // MARK: - Propriedades
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    private let limit = 151

    // MARK: - Métodos Públicos
    func fetchPrimeiraGeracao() async throws -> [Pokemon] {
        guard let urlLista = URL(string: "\(baseURL)?limit=\(limit)&offset=0") else {
            throw HomeAPIServiceError.urlInvalida
        }

        let (dadosLista, _) = try await URLSession.shared.data(from: urlLista)
        
        let respostaLista: PokemonListResponse
        do {
            respostaLista = try JSONDecoder().decode(PokemonListResponse.self, from: dadosLista)
        } catch {
            throw HomeAPIServiceError.falhaNaDecodificacao(error)
        }
        
        var pokemonsDetalhes: [Pokemon] = []
        try await withThrowingTaskGroup(of: Pokemon?.self, body: { group in
            for item in respostaLista.results {
                group.addTask {
                    guard let urlDetalhe = URL(string: item.url) else { return nil }
                    
                    do {
                        let (dadosDetalhe, _) = try await URLSession.shared.data(from: urlDetalhe)
                        return try JSONDecoder().decode(Pokemon.self, from: dadosDetalhe)
                    } catch {
                        print("DEBUG: Falha ao buscar/decodificar detalhes para \(item.name): \(error.localizedDescription)")
                        return nil
                    }
                }
            }
            
            for try await pokemon in group {
                if let pokemon = pokemon {
                    pokemonsDetalhes.append(pokemon)
                }
            }
        })
        
        return pokemonsDetalhes.sorted { $0.id < $1.id }
    }
}
