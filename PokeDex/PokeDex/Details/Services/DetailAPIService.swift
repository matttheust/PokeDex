//
//  DetailAPIService.swift
//  PokeDex
//
//  Created by Matheus  Torres on 26/05/25.
//

import Foundation
import SwiftUI

// MARK: - Erros do Serviço de Detalhes
enum DetailAPIServiceError: Error {
    case urlInvalida
    case falhaNaRede(Error)
    case falhaNaDecodificacao(Error)
    case dadosNaoEncontrados
    case especieNaoEncontrada
}

// MARK: - Serviço de API de Detalhes
class DetailAPIService {
    // MARK: - Propriedades
    private let baseURL = "https://pokeapi.co/api/v2"

    // MARK: - Método Principal de Busca
    func fetchPokemonDetails(for pokemonId: Int) async throws -> PokemonFullDetails {
        guard let pokemonURL = URL(string: "\(baseURL)/pokemon/\(pokemonId)") else {
            throw DetailAPIServiceError.urlInvalida
        }

        let (pokemonData, _) = try await URLSession.shared.data(from: pokemonURL)
        
        let apiDetailResponse: APIPokemonDetailResponse
        do {
            apiDetailResponse = try JSONDecoder().decode(APIPokemonDetailResponse.self, from: pokemonData)
        } catch {
            // print("DEBUG: Erro ao decodificar APIPokemonDetailResponse para ID \(pokemonId): \(error)")
            throw DetailAPIServiceError.falhaNaDecodificacao(error)
        }

        guard let speciesURL = URL(string: apiDetailResponse.species.url) else {
            // print("DEBUG: URL da espécie inválida para ID \(pokemonId): \(apiDetailResponse.species.url)")
            throw DetailAPIServiceError.especieNaoEncontrada
        }

        let (speciesData, _) = try await URLSession.shared.data(from: speciesURL)
        
        let apiSpeciesResponse: APISpeciesResponse
        do {
            apiSpeciesResponse = try JSONDecoder().decode(APISpeciesResponse.self, from: speciesData)
        } catch {
            // print("DEBUG: Erro ao decodificar APISpeciesResponse para ID \(pokemonId) (URL: \(speciesURL)): \(error)")
            throw DetailAPIServiceError.falhaNaDecodificacao(error)
        }

        return try mapToPokemonFullDetails(
            apiDetail: apiDetailResponse,
            apiSpecies: apiSpeciesResponse
        )
    }

    // MARK: - Método Privado de Mapeamento
    private func mapToPokemonFullDetails(apiDetail: APIPokemonDetailResponse, apiSpecies: APISpeciesResponse) throws -> PokemonFullDetails {
        let imageUrlString = apiDetail.sprites.other?.officialArtwork?.frontDefault ?? apiDetail.sprites.frontDefault
        let imageUrl = URL(string: imageUrlString)

        let types: [PokemonType] = apiDetail.types.compactMap { PokemonType(apiName: $0.type.name) }
                                             .sorted { $0.rawValue < $1.rawValue }

        guard let firstType = types.first else {
            throw DetailAPIServiceError.dadosNaoEncontrados
        }
        let primaryTypeColor = firstType.swiftUIColor

        let weightInKg = Double(apiDetail.weight) / 10.0
        let heightInM = Double(apiDetail.height) / 10.0

        let abilities: [String] = apiDetail.abilities.map {
            $0.ability.name.replacingOccurrences(of: "-", with: " ").capitalized
        }

        let description = apiSpecies.flavorTextEntries
            .first { $0.language.name == "en" }?
            .flavorText
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{000C}", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? "Descrição não disponível."

        let stats: [PokemonStatDetail] = apiDetail.stats.map { apiStatEntry in
            let statName = apiStatEntry.stat.name
            let shortName: String
            switch statName.lowercased() {
                case "hp": shortName = "HP"
                case "attack": shortName = "ATK"
                case "defense": shortName = "DEF"
                case "special-attack": shortName = "Sp. Atk"
                case "special-defense": shortName = "Sp. Def"
                case "speed": shortName = "SPD"
                default: shortName = statName.prefix(3).uppercased()
            }
            return PokemonStatDetail(
                name: statName,
                shortName: shortName,
                baseValue: apiStatEntry.baseStat,
                effort: apiStatEntry.effort
            )
        }

        return PokemonFullDetails(
            id: apiDetail.id,
            name: apiDetail.name.capitalized,
            imageUrl: imageUrl,
            types: types,
            weightInKg: weightInKg,
            heightInM: heightInM,
            abilities: abilities,
            description: description,
            stats: stats,
            primaryTypeColor: primaryTypeColor
        )
    }
}
