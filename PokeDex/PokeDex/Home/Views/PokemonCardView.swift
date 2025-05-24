//
//  PokemonCardView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import SwiftUI

// MARK: - Card do Pokémon
struct PokemonCardView: View {
    // MARK: - Propriedades
    let pokemon: Pokemon

    // MARK: - Corpo da View
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // MARK: - Fundo Principal do Card
            Color(AppColor.white)
                .cornerRadius(12)
                .shadow(color: Color(AppColor.grayDark).opacity(0.15), radius: 4, x: 0, y: 2)
            
            // MARK: - Conteúdo do Card
            VStack(spacing: 0) {
                // MARK: - Área da Imagem
                Spacer()
                AsyncImage(url: pokemon.imageUrl) { phase in // Carregando a imagem
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                    case .failure:
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color(AppColor.grayMedium))
                    case .empty:
                        ProgressView()
                            .frame(width: 75, height: 75)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 90)
                Spacer()
                
                // MARK: - Área do Nome
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(AppColor.grayBackground).opacity(0.5),
                        Color(AppColor.grayLight).opacity(0.7)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 60)
                .overlay(
                    Text(pokemon.capitalizedName)
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(Color(AppColor.grayDark))
                        .lineLimit(1)
                        .padding(.horizontal, 8)
                )
                .clipShape(
                    .rect(
                        topLeadingRadius: 20,
                        topTrailingRadius: 20
                    )
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // MARK: - Número do Pokémon
            Text(pokemon.formattedId)
                .font(.caption2.weight(.bold))
                .foregroundColor(Color(AppColor.grayDark).opacity(0.7))
                .padding(6)
                .background(Color(AppColor.white).opacity(0.5).blur(radius: 2))
                .clipShape(Capsule())
                .padding(5)
        }
        .frame(height: 160)
    }
}

// MARK: - Previews
struct PokemonCardView_Previews: PreviewProvider {
    static var previews: some View {
        let pikachuPreview = Pokemon(
            id: 25,
            name: "Pikachu",
            sprites: PokemonSprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
                other: OtherSprites(
                    officialArtwork: OfficialArtwork(
                        frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
                    )
                )
            )
        )
        let bulbasaurPreview = Pokemon(
            id: 1,
            name: "Bulbasaur",
            sprites: PokemonSprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                other: OtherSprites(
                    officialArtwork: OfficialArtwork(
                        frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
                    )
                )
            )
        )

        Grid {
            GridRow {
                PokemonCardView(pokemon: pikachuPreview)
                PokemonCardView(pokemon: bulbasaurPreview)
            }
            GridRow {
                PokemonCardView(pokemon: Pokemon(id: 4, name: "Charmander", sprites: PokemonSprites(frontDefault: "", other: nil)))
                PokemonCardView(pokemon: Pokemon(id: 7, name: "Squirtle", sprites: PokemonSprites(frontDefault: "", other: nil)))
            }
        }
        .padding()
        .background(Color(AppColor.grayBackground))
    }
}
