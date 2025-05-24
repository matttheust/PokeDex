//
//  Pokemon.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import Foundation

// MARK: - Pokémon (Lista)
struct Pokemon: Identifiable, Decodable {
    let id: Int
    let name: String
    let sprites: PokemonSprites

    var formattedId: String {
        String(format: "#%03d", id)
    }
    
    var capitalizedName: String {
        name.capitalized
    }
    
    var imageUrl: URL? {
        let urlString = sprites.other?.officialArtwork?.frontDefault ?? sprites.frontDefault
        return URL(string: urlString)
    }
}

// MARK: - Sprites do Pokémon
struct PokemonSprites: Decodable {
    let frontDefault: String
    let other: OtherSprites?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

// MARK: - Outros Sprites
struct OtherSprites: Decodable {
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: - Arte Oficial
struct OfficialArtwork: Decodable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
