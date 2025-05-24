//
//  PokemonGridView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

// PokedexApp/Home/Views/PokemonGridView.swift
import SwiftUI

// MARK: - Grade de Pokémon
struct PokemonGridView: View {
    // MARK: - Propriedades
    let pokemons: [Pokemon]
    @Binding var selectedPokemon: Pokemon?

    // MARK: - Configuração da Grade
    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 16), // Espaçamento HORIZONTAL após esta coluna
        GridItem(.flexible())              // A última coluna não precisa de 'spacing' aqui
    ]

    // MARK: - Corpo da View
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: gridColumns,
                spacing: 16 // Espaçamento VERTICAL entre as linhas
            ) {
                ForEach(pokemons) { pokemon in
                    PokemonCardView(pokemon: pokemon)
                        .onTapGesture {
                            self.selectedPokemon = pokemon
                        }
                }
            }
            .padding(.horizontal, 16) // Padding nas laterais da grade inteira
            .padding(.vertical, 8)    // Padding no topo e na base da grade inteira
        }
    }
}

// MARK: - Previews
struct PokemonGridView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock data para o preview
        let mockPokemons = [
            Pokemon(id: 1, name: "Bulbasaur", sprites: PokemonSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", other: OtherSprites(officialArtwork: OfficialArtwork(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")))),
            Pokemon(id: 4, name: "Charmander", sprites: PokemonSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png", other: OtherSprites(officialArtwork: OfficialArtwork(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png")))),
            Pokemon(id: 7, name: "Squirtle", sprites: PokemonSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png", other: OtherSprites(officialArtwork: OfficialArtwork(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png")))),
            Pokemon(id: 25, name: "Pikachu", sprites: PokemonSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png", other: OtherSprites(officialArtwork: OfficialArtwork(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"))))
        ]
        
        // Para ver o efeito da grade, é melhor dar um contexto de navegação ou um ZStack com cor.
        NavigationView { // Ou NavigationStack se preferir
            PokemonGridView(pokemons: mockPokemons, selectedPokemon: .constant(nil))
                .background(Color(AppColor.primary).opacity(0.1)) // Um fundo leve
                .navigationTitle("Pokédex Preview")
        }
    }
}
