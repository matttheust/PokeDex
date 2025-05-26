//
//  PokemonFullDetails.swift
//  PokeDex
//
//  Created by Matheus  Torres on 26/05/25.
//


// PokedexApp/Details/Models/DetailPokemonModels.swift
import Foundation
import SwiftUI

// MARK: - Modelo Principal para View de Detalhes
struct PokemonFullDetails: Identifiable, Equatable {
    let id: Int
    let name: String
    let imageUrl: URL?
    let types: [PokemonType]
    let weightInKg: Double
    let heightInM: Double
    let abilities: [String]
    let description: String
    let stats: [PokemonStatDetail]
    let primaryTypeColor: Color
}

// MARK: - Modelo para Estatísticas Individuais
struct PokemonStatDetail: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let shortName: String
    let baseValue: Int
    let effort: Int
}

// MARK: - Decodificação API /pokemon/{id}
struct APIPokemonDetailResponse: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites 
    let types: [APIPokemonTypeEntry]
    let abilities: [APIAbilityEntry]
    let stats: [APIStatEntry]
    let species: APIResourceURL
}

struct APIPokemonTypeEntry: Decodable {
    let slot: Int
    let type: APIResourceURL
}

struct APIAbilityEntry: Decodable {
    let ability: APIResourceURL
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct APIStatEntry: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: APIResourceURL

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct APIResourceURL: Decodable {
    let name: String
    let url: String
}

// MARK: - Decodificação API /pokemon-species/{id}
struct APISpeciesResponse: Decodable {
    let flavorTextEntries: [APIFlavorTextEntry]

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct APIFlavorTextEntry: Decodable {
    let flavorText: String
    let language: APIResourceURL

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

// TODO: Definir como transformar APIPokemonDetailResponse e APISpeciesResponse em PokemonFullDetails.
//       Isso pode ser feito no DetailAPIService ou com um init customizado em PokemonFullDetails.
