//
//  PokemonListResponse.swift
//  PokeDex
//
//  Created by Matheus  Torres on 18/04/25.
//

import Foundation

struct PokemonListResponse: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}

struct PokemonDetail: Decodable {
    let sprites: Sprites
    let types: [PokemonType]
}

struct Sprites: Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonType: Decodable {
    let type: TypeDetail
}

struct TypeDetail: Decodable {
    let name: String
}
