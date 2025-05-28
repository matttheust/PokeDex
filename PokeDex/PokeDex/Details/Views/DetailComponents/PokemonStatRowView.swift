//
//  PokemonStatRowView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 28/05/25.
//

import SwiftUI

// MARK: - View Linha de Estatística
struct PokemonStatRowView: View {
    // MARK: - Propriedades
    let stat: PokemonStatDetail
    let typeColor: Color

    private let maxStatValueForBar: Double = 200.0 

    // MARK: - Corpo da View
    var body: some View {
        HStack(spacing: 8) {
            Text(stat.shortName)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(AppColor.grayDark))
                .frame(width: 65, alignment: .leading) 

            Text("\(stat.baseValue)")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(typeColor)
                .frame(width: 35, alignment: .trailing)

            ProgressView(value: Double(stat.baseValue), total: maxStatValueForBar)
                .progressViewStyle(LinearProgressViewStyle(tint: typeColor))
                .frame(height: 8)
                .clipShape(Capsule())
        }
    }
}

// MARK: - Previews
struct PokemonStatRowView_Previews: PreviewProvider {
    static var previews: some View {
        let mockStatHP = PokemonStatDetail(
            name: "hp",
            shortName: "HP",
            baseValue: 45,
            effort: 0
        )
        let mockStatAttack = PokemonStatDetail(
            name: "attack",
            shortName: "ATK",
            baseValue: 110,
            effort: 2
        )
        
        let grassColor = PokemonType(apiName: "grass")?.swiftUIColor ?? .green
        let fireColor = PokemonType(apiName: "fire")?.swiftUIColor ?? .red
        
        VStack(alignment: .leading, spacing: 10) {
            PokemonStatRowView(stat: mockStatHP, typeColor: grassColor)
            PokemonStatRowView(stat: mockStatAttack, typeColor: fireColor)
        }
        .padding()
        .background(Color(AppColor.detailCardBackground))
        .previewLayout(.sizeThatFits)
    }
}
