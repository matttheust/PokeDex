//
//  HomeHeaderView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//


// PokedexApp/Home/Views/HomeHeaderView.swift
import SwiftUI

// MARK: - Cabeçalho da Home
struct HomeHeaderView: View {
    // MARK: - Propriedades
    @Binding var searchText: String // Campo de busca

    // MARK: - Corpo da View
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                // TODO: Adicionar sua imagem "pokeball" aqui se tiver no Assets
                // Image("pokeball")
                //     .resizable()
                //     .frame(width: 30, height: 30)
                Text("Pokédex")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(Color(AppColor.white))
                Spacer()
                FilterButton()
            }
            .padding(.horizontal)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(AppColor.primary))
                TextField("Buscar Pokémon ou Nº...", text: $searchText)
                    .foregroundColor(Color(AppColor.grayDark))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(AppColor.white))
            .cornerRadius(25)
            .padding(.horizontal)
        }
    }
}

// MARK: - Previews (Opcional para Subviews, mas útil)
struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(searchText: .constant(""))
            .padding()
            .background(Color(AppColor.primary))
            .previewLayout(.sizeThatFits)
    }
}
