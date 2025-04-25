//
//  ContentView.swift
//  PokeDex
//
//  Created by Matheus  Torres on 17/04/25.
//

import SwiftUI

// MARK: - ViewModel Atualizado
class PokemonViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchPokemons() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            errorMessage = "URL inválida"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    self?.errorMessage = "Resposta inválida do servidor"
                    return
                }
                
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                        self?.pokemons = response.results
                    } catch {
                        self?.errorMessage = "Falha ao decodificar os dados: \(error.localizedDescription)"
                    }
                }
            }
        }.resume()
    }
    
    // Função mais robusta para extrair o ID
    func getPokemonId(from url: String) -> Int? {
        let components = url.components(separatedBy: "/")
        guard components.count >= 2 else { return nil }
        let idString = components[components.count - 2]
        return Int(idString)
    }
}

// MARK: - View Atualizada
struct ContentView: View {
    @StateObject var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Carregando Pokémon...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erro: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon, viewModel: viewModel)) {
                            PokemonRow(pokemon: pokemon, viewModel: viewModel)
                        }
                    }
                    .navigationTitle("Pokédex")
                }
            }
            .onAppear {
                if viewModel.pokemons.isEmpty {
                    viewModel.fetchPokemons()
                }
            }
        }
    }
}

struct PokemonRow: View {
    let pokemon: Pokemon
    let viewModel: PokemonViewModel
    
    var body: some View {
        HStack {
            if let id = viewModel.getPokemonId(from: pokemon.url) {
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    case .failure:
                        Image(systemName: "questionmark.circle")
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "questionmark.circle")
                    .frame(width: 50, height: 50)
            }
            
            Text(pokemon.name.capitalized)
                .font(.headline)
        }
    }
}

struct PokemonDetailView: View {
    let pokemon: Pokemon
    let viewModel: PokemonViewModel
    @State private var pokemonDetail: PokemonDetail?
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoading {
                ProgressView("Carregando detalhes...")
            } else if let errorMessage = errorMessage {
                Text("Erro: \(errorMessage)")
                    .foregroundColor(.red)
            } else if let detail = pokemonDetail {
                AsyncImage(url: URL(string: detail.sprites.frontDefault)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    case .failure:
                        Image(systemName: "questionmark.circle")
                            .frame(width: 200, height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                if !detail.types.isEmpty {
                    VStack {
                        Text("Types:")
                            .font(.title2)
                        
                        ForEach(detail.types, id: \.type.name) { type in
                            Text(type.type.name.capitalized)
                                .font(.headline)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding()
        .navigationTitle(pokemon.name.capitalized)
        .onAppear {
            fetchPokemonDetail()
        }
    }
    
    func fetchPokemonDetail() {
        guard pokemonDetail == nil else { return }
        
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: pokemon.url) else {
            errorMessage = "URL inválida"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    errorMessage = "Resposta inválida do servidor"
                    return
                }
                
                if let data = data {
                    do {
                        pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                    } catch {
                        errorMessage = "Falha ao decodificar os detalhes: \(error.localizedDescription)"
                    }
                }
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
