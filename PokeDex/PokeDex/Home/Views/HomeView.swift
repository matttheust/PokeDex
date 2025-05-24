//
//  HomeView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import SwiftUI

// MARK: - Tela Principal (Home)
struct HomeView: View {
    // MARK: - Estados e ViewModel
    @StateObject private var viewModel = PokemonViewModel()
    @State private var searchText: String = ""
    @State private var selectedPokemon: Pokemon? // Para apresentar a tela de detalhes

    // MARK: - Propriedades Computadas
    private var filteredPokemons: [Pokemon] {
        if searchText.isEmpty {
            return viewModel.pokemons
        } else {
            return viewModel.pokemons.filter { pokemon in
                pokemon.capitalizedName.localizedCaseInsensitiveContains(searchText) ||
                pokemon.formattedId.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // MARK: - Corpo da View
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Fundo
                Color(AppColor.primary)
                    .ignoresSafeArea()

                // MARK: - Conteúdo Principal
                VStack(spacing: 0) {
                    HomeHeaderView(searchText: $searchText)
                        .padding(.bottom, 20)

                    if viewModel.isLoading && viewModel.pokemons.isEmpty {
                        StatusIndicatorView(isLoading: true, errorMessage: nil, retryAction: nil)
                    } else if let errorMessage = viewModel.errorMessage {
                        StatusIndicatorView(isLoading: false, errorMessage: errorMessage) {
                            viewModel.carregarPokemons() // Ação de tentar novamente
                        }
                    } else {
                        PokemonGridView(pokemons: filteredPokemons, selectedPokemon: $selectedPokemon)
                    }
                }
                .padding(.top, 20)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            if viewModel.pokemons.isEmpty {
                viewModel.carregarPokemons()
            }
        }
        .sheet(item: $selectedPokemon) { pokemon in
            // TODO: Substituir este placeholder pela PokemonDetailView real quando ela for criada.
            // Exemplo: PokemonDetailView(pokemonId: pokemon.id)
            VStack {
                Text("Tela de Detalhes para:")
                Text(pokemon.capitalizedName)
                    .font(.largeTitle)
                Text(pokemon.formattedId)
            }
            .padding()
        }
    }
}

// MARK: - Previews da HomeView
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
