# PokedexApp SwiftUI

![PokeAPI](https://img.shields.io/badge/PokeAPI-v2-yellowgreen?style=for-the-badge)
Uma aplicação Pokédex moderna construída com SwiftUI, consumindo dados da [PokeAPI](https://pokeapi.co/). Este projeto visa demonstrar boas práticas de desenvolvimento iOS com SwiftUI, incluindo componentização, gerenciamento de estado e consumo de APIs.

## 🌟 Funcionalidades Implementadas

- [x] **Tela Home:**
  - [x] Listagem dos primeiros 151 Pokémon.
  - [x] Exibição em grade com cards individuais (`PokemonCardView`).
  - [x] Imagem, nome e ID do Pokémon em cada card.
  - [x] Barra de busca para filtrar Pokémon por nome ou número.
  - [x] Botão de filtro (UI implementada, lógica pendente).
  - [x] Indicador de carregamento e tratamento de erros básicos.
- [x] **Estrutura do Projeto:**
  - [x] Organização em módulos/pastas (Shared, Home, Details).
  - [x] Componentização de Views.
  - [x] Gerenciamento de estado com `ObservableObject` (ViewModels).
  - [x] Consumo de API de forma assíncrona com `async/await`.
- [ ] **Tela de Detalhes do Pokémon:** (Próxima grande feature)
  - [ ] Exibição de informações detalhadas: imagem maior, tipos, descrição, estatísticas base, peso, altura, habilidades.
  - [ ] Navegação a partir da Tela Home.
- [ ] **Funcionalidade do Botão de Filtro:**
  - [ ] Implementar lógica para filtrar a lista de Pokémon por tipo ou outros critérios.
- [ ] **Testes Unitários e de UI.**
- [ ] **Documentação Adicional na Wiki.**

## 🛠️ Tecnologias Utilizadas

* **SwiftUI**: Para a construção da interface de usuário declarativa e moderna.
* **Swift Concurrency (`async/await`, `TaskGroup`)**: Para chamadas de rede assíncronas e eficientes.
* **Combine**: (Implicitamente usado por SwiftUI com `@StateObject`, `@ObservedObject`, `@Published`) para programação reativa.
* **PokeAPI (v2)**: Como fonte de dados para todas as informações dos Pokémon.
* **Xcode**: Ambiente de desenvolvimento.
* **Git & GitHub**: Para controle de versão e gerenciamento do projeto.

## 🤝 Contribuições 

Contribuições são bem-vindas! Se você tem sugestões ou quer corrigir algo, sinta-se à vontade para abrir uma Issue ou um Pull Request.

