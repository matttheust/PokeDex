//
//  FilterButton.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import SwiftUI

// MARK: - Botão de Filtro
struct FilterButton: View {
    // MARK: - Estados
    @State private var isActive: Bool = false

    // MARK: - Corpo da View
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                self.isActive.toggle()
            }
        }) {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .symbolVariant(isActive ? .fill : .none)
                .font(.system(size: 24))
                .foregroundColor(isActive ? Color(AppColor.primary) : Color(AppColor.grayMedium))
                .padding(15)
                .background {
                    Circle()
                        .fill(Color(uiColor: .systemGray6))
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                }
                .overlay {
                    Circle()
                        .stroke(isActive ? Color(AppColor.primary) : Color(AppColor.grayMedium).opacity(0.5), lineWidth: 1)
                }
        }
    }
}

// MARK: - Previews
struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
