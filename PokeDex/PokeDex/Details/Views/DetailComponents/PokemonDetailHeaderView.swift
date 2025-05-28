//
//  PokemonDetailHeaderView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 28/05/25.
//

// PokedexApp/Details/Views/DetailComponents/PokemonDetailHeaderView.swift
import SwiftUI

// MARK: - Cabeçalho da Tela de Detalhes
struct PokemonDetailHeaderView: View {
    // MARK: - Propriedades
    let details: PokemonFullDetails
    @Environment(\.dismiss) private var dismiss
    
    var onPreviousPokemon: (() -> Void)? = nil
    var onNextPokemon: (() -> Void)? = nil

    // MARK: - Corpo da View
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: - Fundo Dinâmico do Header
            details.primaryTypeColor.opacity(0.5)
                .ignoresSafeArea(edges: .top)

            // MARK: - Pokebola de Fundo
            Image("Pokeball_big")
                .resizable()
                .scaledToFit()
                .frame(width: 190, height: 190)
                .foregroundColor(.white.opacity(0.07))
                .offset(x: 55, y: 5)

            // MARK: - Conteúdo Principal do Header
            VStack(spacing: 0) {
                // MARK: - Barra Superior (Voltar, Nome, ID)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44, alignment: .center)
                    }

                    Spacer()

                    Text(details.name)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    Spacer()
                    
                    Text("#\(String(format: "%03d", details.id))")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.75))
                        .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                        .frame(width: 60, alignment: .trailing)
                }
                .padding(.horizontal)
                // Padding no topo da VStack abaixo cuidará do espaço para a safe area.

                // MARK: - Imagem do Pokémon com Navegação
                ZStack {
                    AsyncImage(url: details.imageUrl) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFit()
                        } else if phase.error != nil {
                            Image(systemName: "questionmark.diamond.fill")
                                .resizable().scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white.opacity(0.4))
                        } else {
                            ProgressView().tint(.white)
                                .frame(width: 100, height: 100)
                        }
                    }
                    .frame(height: 190)

                    HStack {
                        Button { onPreviousPokemon?() } label: {
                            Image(systemName: "chevron.left")
                                .font(.title.weight(.bold))
                                .foregroundColor(.white.opacity(0.7))
                                .padding()
                                .contentShape(Rectangle())
                        }
                        .disabled(onPreviousPokemon == nil)
                        .padding(.leading, 4)

                        Spacer()

                        Button { onNextPokemon?() } label: {
                            Image(systemName: "chevron.right")
                                .font(.title.weight(.bold))
                                .foregroundColor(.white.opacity(0.7))
                                .padding()
                                .contentShape(Rectangle())
                        }
                        .disabled(onNextPokemon == nil)
                        .padding(.trailing, 4)
                    }
                    .frame(height: 190)
                }
                .padding(.top, 8)

                // MARK: - Pills de Tipo
                HStack(spacing: 10) {
                    ForEach(details.types) { pokemonType in
                        PillView(type: pokemonType)
                            .shadow(radius: 1)
                    }
                }
                .padding(.top, 8)
            }
            // Padding no topo da VStack para o conteúdo não colar na status bar/Dynamic Island.
            // Use um valor fixo que funcione bem ou o helper da safe area.
            .padding(.top, (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.top ?? 44) // Aumentei o fallback
            // Padding inferior para criar o espaço onde o InfoCardView vai "entrar".
            .padding(.bottom, 40)
        }
        // O header determina sua própria altura pelo conteúdo e paddings.
    }
}

// MARK: - Helper para Safe Area (Mantenha em Utils ou Shared/Extensions)
// Se você já tem isso em outro lugar, pode remover daqui.
// extension UIApplication {
//     var safeAreaInsetsIfAvailable: UIEdgeInsets? {
//         (connectedScenes.first as? UIWindowScene)?.windows.first { $0.isKeyWindow }?.safeAreaInsets
//     }
// }

// MARK: - Previews
// ... (Previews do PokemonDetailHeaderView como estavam, eles devem funcionar bem) ...
struct PokemonDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        // ... (seu mock de details)
        let grassType = PokemonType(apiName: "grass") ?? .normal
        let poisonType = PokemonType(apiName: "poison") ?? .normal
        let mockDetails = PokemonFullDetails(
            id: 1, name: "Bulbasaur",
            imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"),
            types: [grassType, poisonType], weightInKg: 6.9, heightInM: 0.7,
            abilities: ["Overgrow", "Chlorophyll"],
            description: "A strange seed was planted...",
            stats: [PokemonStatDetail(name: "hp", shortName: "HP", baseValue: 45, effort: 0)],
            primaryTypeColor: grassType.swiftUIColor
        )
        PokemonDetailHeaderView(details: mockDetails)
    }
}
