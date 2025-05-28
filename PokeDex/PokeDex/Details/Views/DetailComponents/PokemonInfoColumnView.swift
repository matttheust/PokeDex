//
//  PokemonInfoColumnView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 28/05/25.
//

import SwiftUI

// MARK: - View para Coluna de Informação Genérica
struct PokemonInfoColumnView: View {
    // MARK: - Propriedades
    let iconName: String? // Nome do asset de imagem customizado (opcional)
    let values: [String]
    let labelText: String

    var iconFont: Font = .system(size: 16, weight: .medium)
    var valueFont: Font = .system(size: 12, weight: .regular)
    var labelFont: Font = .system(size: 10, weight: .regular)
    
    var iconColor: Color = Color(AppColor.grayDark)
    var valueColor: Color = Color(AppColor.grayDark)
    var labelColor: Color = Color(AppColor.grayMedium)
    let valueLineHeight: CGFloat = 15

    // MARK: - Corpo da View
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            // MARK: - Ícone (Opcional)
            if let iconName = iconName, !iconName.isEmpty {
                Image(iconName) // Carrega do Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    // .foregroundColor(iconColor) // Aplicar se o asset for template e você quiser tingi-lo
            } else {
                Spacer().frame(width: 20, height: 20)
            }

            // MARK: - Valor 1
            if let value1 = values.first {
                Text(value1)
                    .font(valueFont)
                    .foregroundColor(valueColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(height: valueLineHeight, alignment: .center)
            } else {
                Text("-")
                    .font(valueFont)
                    .foregroundColor(valueColor)
                    .frame(height: valueLineHeight, alignment: .center)
            }

            // MARK: - Valor 2
            if values.count > 1 {
                Text(values[1])
                    .font(valueFont)
                    .foregroundColor(valueColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(height: valueLineHeight, alignment: .center)
            } else {
                Text(" ")
                    .font(valueFont)
                    .frame(height: valueLineHeight, alignment: .center)
                    .opacity(0)
            }
            
            // MARK: - Rótulo
            Text(labelText)
                .font(labelFont)
                .foregroundColor(labelColor)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Previews
struct PokemonInfoColumnView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top, spacing: 16) {
            PokemonInfoColumnView(
                iconName: "weight", // Nome do seu asset customizado
                values: ["6.9 kg"],
                labelText: "Weight"
            )
            Divider().frame(height: 65)
            
            PokemonInfoColumnView(
                iconName: "straighten", // Nome do seu asset customizado
                values: ["0.7 m"],
                labelText: "Height"
            )
            Divider().frame(height: 65)

            PokemonInfoColumnView(
                iconName: nil, // Sem ícone para Moves, conforme design
                values: ["Overgrow", "Chlorophyll"],
                labelText: "Moves"
            )
        }
        .padding()
        .background(Color(AppColor.detailCardBackground))
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Colunas de Informação Unificadas")
    }
}
