//
//  PokemonType.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import SwiftUI // Necessário para Color e Identifiable

// MARK: - Enum Tipos de Pokémon
enum PokemonType: String, CaseIterable, Identifiable {
    // MARK: - Casos do Enum
    case bug, dark, dragon, electric, fairy, fighting, fire, flying,
         ghost, normal, grass, ground, ice, poison, psychic, rock, steel, water

    // MARK: - Propriedades
    /// ID único para conformar com o protocolo `Identifiable`, útil em `ForEach`.
    var id: String { self.rawValue }

    var uiKitColor: UIColor {
        switch self {
        case .bug: return AppColor.bug
        case .dark: return AppColor.dark
        case .dragon: return AppColor.dragon
        case .electric: return AppColor.electric
        case .fairy: return AppColor.fairy
        case .fighting: return AppColor.fighting
        case .fire: return AppColor.fire
        case .flying: return AppColor.flying
        case .ghost: return AppColor.ghost
        case .normal: return AppColor.normal
        case .grass: return AppColor.grass
        case .ground: return AppColor.ground
        case .ice: return AppColor.ice
        case .poison: return AppColor.poison
        case .psychic: return AppColor.psychic
        case .rock: return AppColor.rock
        case .steel: return AppColor.steel
        case .water: return AppColor.water
        }
    }

    var swiftUIColor: Color {
        Color(self.uiKitColor)
    }

    // MARK: - Inicializador - para PokeAPI - Tabela DE-PARA tipos de pokemons - Util nos pills
    /// Inicializador opcional para criar um `PokemonType` a partir do nome do tipo (String)
    /// retornado pela API. A API geralmente retorna nomes em minúsculas.
    init?(apiName: String) {
        self.init(rawValue: apiName.lowercased())
    }
}
