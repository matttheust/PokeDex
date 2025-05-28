//
//  PokemonDetailView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 28/05/25.
//

// PokedexApp/Details/Views/PokemonDetailView.swift
import SwiftUI

// MARK: - Tela de Detalhes do Pokémon
struct PokemonDetailView: View {
    // MARK: - Propriedades e Estados
    @StateObject private var viewModel: PokemonDetailViewModel
        private let screenBackgroundColor = Color(AppColor.grayDark)

        init(pokemonId: Int) {
            _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(pokemonId: pokemonId))
        }

        var body: some View {
            ZStack {
                screenBackgroundColor
                    .ignoresSafeArea()

                if viewModel.isLoading && viewModel.pokemonDetails == nil {
                    StatusIndicatorView(isLoading: true, errorMessage: nil, retryAction: nil)
                } else if let errorMessage = viewModel.errorMessage, viewModel.pokemonDetails == nil {
                    StatusIndicatorView(isLoading: false, errorMessage: errorMessage) {
                        viewModel.carregarDetalhes()
                    }
                } else if let details = viewModel.pokemonDetails {
                    GeometryReader { geometry in // Usando GeometryReader
                        VStack(spacing: 0) {
                            PokemonDetailHeaderView(
                                details: details,
                                onPreviousPokemon: { /* TODO */ },
                                onNextPokemon: { /* TODO */ }
                            )
                            .frame(height: geometry.size.height * 0.45) // Ex: Header ocupa 45% da tela (ajuste)
                            // Ou uma altura fixa se preferir: .frame(height: 300)
                            
                            PokemonDetailInfoCardView(details: details)
                                // O offset precisa ser ajustado em relação à altura do header
                                .offset(y: -20)
                                // O InfoCardView tentará ocupar o restante do espaço.
                                // O Spacer interno dele ajudará.
                            Spacer()
                        }
                    }
                    .ignoresSafeArea(edges: .top)
                     
                } else {
                    StatusIndicatorView(isLoading: false, errorMessage: "Nenhum detalhe para exibir.") {
                        viewModel.carregarDetalhes()
                    }
                }
            }
        }
    }

// MARK: - Previews da PokemonDetailView
struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemonId: 1)
        }
        .preferredColorScheme(.light)

        NavigationView {
            PokemonDetailView(pokemonId: 4)
        }
        .preferredColorScheme(.dark)
    }
}
