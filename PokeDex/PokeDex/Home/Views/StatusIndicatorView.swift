//
//  StatusIndicatorView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//


// PokedexApp/Home/Views/StatusIndicatorView.swift
import SwiftUI

// MARK: - Indicador de Status (Carregamento/Erro)
struct StatusIndicatorView: View {
    // MARK: - Propriedades
    let isLoading: Bool
    let errorMessage: String?
    var retryAction: (() -> Void)? = nil // Ação opcional para o botão "Tentar Novamente"

    // MARK: - Corpo da View
    var body: some View {
        // O Spacer ajuda a centralizar o conteúdo verticalmente se esta View ocupar todo o espaço disponível.
        Spacer()
        if isLoading {
            ProgressView()
                .scaleEffect(1.5) // Torna o ProgressView um pouco maior
                .tint(Color(AppColor.white)) // Cor do ProgressView
        } else if let message = errorMessage {
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle.fill") // Ícone de alerta
                    .font(.largeTitle)
                    .foregroundColor(Color(AppColor.white).opacity(0.8))
                Text(message)
                    .font(.headline)
                    .foregroundColor(Color(AppColor.white))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                if let retryAction = retryAction {
                    Button("Tentar Novamente", action: retryAction)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(AppColor.white).opacity(0.3)) // Cor do botão
                        .foregroundColor(Color(AppColor.white)) // Cor do texto do botão
                }
            }
            .padding() // Espaçamento interno para o conteúdo de erro
        }
        Spacer()
    }
}

// MARK: - Previews
struct StatusIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatusIndicatorView(isLoading: true, errorMessage: nil, retryAction: nil)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(AppColor.primary))
                .previewDisplayName("Carregando")

            StatusIndicatorView(isLoading: false, errorMessage: "Falha ao carregar os Pokémon. Verifique sua conexão.", retryAction: { print("Retry Tapped") })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(AppColor.primary))
                .previewDisplayName("Erro com Botão")
            
            StatusIndicatorView(isLoading: false, errorMessage: "Nenhum dado encontrado.", retryAction: nil)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(AppColor.primary))
                .previewDisplayName("Erro sem Botão")
        }
    }
}