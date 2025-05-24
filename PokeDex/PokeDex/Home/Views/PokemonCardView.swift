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
                .shadow(color: Color(AppColor.grayDark).opacity(0.2), radius: 5, x: 0, y: 2)
            
            // MARK: - Conteúdo do Card
            VStack(spacing: 0) {
                // MARK: - Área da Imagem
                Color(AppColor.white)
                    .frame(height: 120)
                    .overlay(
                        AsyncImage(url: pokemon.imageUrl) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            case .failure:
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(Color(AppColor.grayMedium))
                            case .empty:
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .offset(y: 45)
                    )
                
                // MARK: - Área do Nome
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(AppColor.grayLight).opacity(0.15),
                        Color(AppColor.grayLight).opacity(0.25)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 100)
                .overlay(
                    Text(pokemon.capitalizedName)
                        .font(.headline)
                        .foregroundColor(Color(AppColor.grayDark))
                        .padding(.top, 50)
                )
                .clipShape(
                    .rect( // UnevenRoundedRectangle nativa (iOS 17+)
                        topLeadingRadius: 25,
                        topTrailingRadius: 25
                    )
                )
                .padding(.top, -20)
            }
            .cornerRadius(12)
            .clipped()
            
            // MARK: - Número do Pokémon
            Text(pokemon.formattedId)
                .font(.caption)
                .foregroundColor(Color(AppColor.grayMedium))
                .padding(8)
        }
        .frame(width: 200, height: 200)
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
        
        PokemonCardView(pokemon: pikachuPreview)
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color.gray.opacity(0.1))
    }
}
