//
//  PillView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import SwiftUI

// MARK: - PillView
struct PillView: View {
    // MARK: - Propriedades
    let type: PokemonType

    // MARK: - Corpo da View
    var body: some View {
        Text(type.rawValue.capitalized)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color(AppColor.white))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(type.swiftUIColor)
            .cornerRadius(20)
    }
}

// MARK: - Previews - TESTE
struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack(spacing: 8) {
                Text("Visualização de Tipos:")
                    .font(.headline)
                ForEach(PokemonType.allCases) { pokemonType in
                    PillView(type: pokemonType)
                }
            }
            .padding()
            .background(Color(AppColor.grayBackground))
            
            PillView(type: .fighting)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
