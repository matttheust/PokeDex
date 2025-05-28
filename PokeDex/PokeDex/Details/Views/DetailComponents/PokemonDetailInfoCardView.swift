//
//  PokemonDetailInfoCardView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 28/05/25.
//

// PokedexApp/Details/Views/DetailComponents/PokemonDetailInfoCardView.swift
import SwiftUI

// MARK: - Card de Informações Detalhadas do Pokémon
struct PokemonDetailInfoCardView: View {
    // MARK: - Propriedades
    let details: PokemonFullDetails
    private let cardBackgroundColor = Color(AppColor.detailCardBackground)
    private let textColor = Color(AppColor.grayDark)
    private let sectionTitleFont = Font.system(size: 18, weight: .bold)
    private let descriptionFont = Font.system(size: 12, weight: .regular)
    private let descriptionColor = Color(AppColor.grayDark).opacity(0.85)

    // MARK: - Corpo da View
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            // MARK: - Seção "About"
            Text("About")
                .font(sectionTitleFont)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 30) // Espaço para o header "vazar" (AJUSTE ESTE VALOR)

            HStack(alignment: .top, spacing: 8) {
                PokemonInfoColumnView(
                    iconName: "weight", // Seu asset
                    values: ["\(String(format: "%.1f", details.weightInKg)) kg"],
                    labelText: "Weight"
                )
                Divider().frame(height: 65)
                PokemonInfoColumnView(
                    iconName: "straighten", // Seu asset
                    values: ["\(String(format: "%.1f", details.heightInM)) m"],
                    labelText: "Height"
                )
                Divider().frame(height: 65)
                PokemonInfoColumnView(
                    iconName: nil,
                    values: Array(details.abilities.prefix(2)),
                    labelText: "Moves"
                )
            }
            .padding(.horizontal)

            // MARK: - Seção "Description"
            Text(details.description)
                                .font(descriptionFont)
                                .foregroundColor(descriptionColor)
                                // Para o Text se expandir e quebrar linhas, ele precisa saber que pode usar a largura disponível.
                                .frame(maxWidth: .infinity, alignment: .leading) // Garante que ele use a largura
                                 .fixedSize(horizontal: false, vertical: true) // FORÇA o Text a se expandir verticalmente para mostrar todo o conteúdo.
                                                                              // Isso é crucial se o pai não está dando espaço suficiente.
                                .padding(.horizontal)
                                .padding(.top, 8)

            // MARK: - Seção "Base Stats"
            Text("Base Stats")
                .font(sectionTitleFont)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)
            
            VStack(spacing: 6) {
                ForEach(details.stats) { stat in
                    PokemonStatRowView(stat: stat, typeColor: details.primaryTypeColor)
                }
            }
            .padding(.horizontal)
            
            Spacer(minLength: 480) // Para empurrar o conteúdo para cima dentro do card
        }
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity)
        .background(cardBackgroundColor)
        .cornerRadius(35, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
    }
}

// MARK: - Previews
struct PokemonDetailInfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        // ... (seu mock de details)
        let grassType = PokemonType(apiName: "grass") ?? .normal
        let mockDetails = PokemonFullDetails(
            id: 1, name: "Bulbasaur",
            imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"),
            types: [grassType], weightInKg: 6.9, heightInM: 0.7,
            abilities: ["Overgrow", "Chlorophyll"],
            description: "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun's rays, the seed grows progressively larger.",
            stats: [PokemonStatDetail(name: "hp", shortName: "HP", baseValue: 45, effort: 0)],
            primaryTypeColor: grassType.swiftUIColor
        )
        PokemonDetailInfoCardView(details: mockDetails)
            .padding(.top, 50)
            .background(Color.gray)
    }
}
