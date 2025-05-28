//
//  RoundedCorner.swift
//  PokeDex
//
//  Created by Matheus  Torres on 28/05/25.
//

import SwiftUI

// MARK: - Shape para Cantos Arredondados Individuais
// Usada pela extensão View.cornerRadius para aplicar o clipShape.
struct RoundedCorner: Shape {
    // MARK: - Propriedades
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners // UIRectCorner especifica os cantos a arredondar

    // MARK: - Path
    // Cria o caminho para a forma com os cantos especificados arredondados.
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Extensão View para Arredondar Cantos Específicos
extension View {
    /// Arredonda cantos específicos de uma view.
    /// - Parameters:
    ///   - radius: O raio a ser usado para os cantos.
    ///   - corners: Um `UIRectCorner` especificando quais cantos arredondar.
    ///              Exemplos: `.topLeft`, `.topRight`, `[.topLeft, .bottomLeft]`.
    /// - Returns: Uma view com os cantos especificados arredondados.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
