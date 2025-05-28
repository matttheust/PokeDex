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
    @State private var selectedPokemon: Pokemon? // Para apresentar a tela de detalhes via .sheet

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
        NavigationStack { // Ou NavigationView se preferir/precisar de compatibilidade
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
                            viewModel.carregarPokemons()
                        }
                    } else {
                        PokemonGridView(pokemons: filteredPokemons, selectedPokemon: $selectedPokemon)
                    }
                }
                .padding(.top, 20) // Padding para o conteúdo não colar na status bar se não usar navigationBar
            }
            .navigationBarHidden(true) // Esconde a barra de navegação padrão do NavigationStack
        }
        .onAppear {
            if viewModel.pokemons.isEmpty {
                viewModel.carregarPokemons()
            }
        }
        // MARK: - Apresentação da Tela de Detalhes
        .sheet(item: $selectedPokemon) { pokemonSelecionadoNaLista in
            // Chama a PokemonDetailView real, passando o ID do Pokémon selecionado.
            // A PokemonDetailView tem seu próprio botão de voltar que usa @Environment(\.dismiss)
            // para fechar a sheet.
            PokemonDetailView(pokemonId: pokemonSelecionadoNaLista.id)
        }
    }
}

// MARK: - Previews da HomeView
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
