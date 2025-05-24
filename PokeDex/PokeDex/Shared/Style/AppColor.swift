//
//  AppColor.swift
//  PokeDex
//
//  Created by Matheus  Torres on 23/05/25.
//

import UIKit

// MARK: - Cores do App
enum AppColor {
    // MARK: - Identidade
    static let primary = UIColor(hex: "#DC0A2D")

    // MARK: - Cores dos Tipos de Pokemons
    static let bug = UIColor(hex: "#A7B723")
    static let dark = UIColor(hex: "#75574C")
    static let dragon = UIColor(hex: "#7037FF")
    static let electric = UIColor(hex: "#F9CF30")
    static let fairy = UIColor(hex: "#E69EAC")
    static let fighting = UIColor(hex: "#C12239")
    static let fire = UIColor(hex: "#F57D31")
    static let flying = UIColor(hex: "#A891EC")
    static let ghost = UIColor(hex: "#70559B")
    static let normal = UIColor(hex: "#AAA67F")
    static let grass = UIColor(hex: "#74CB48")
    static let ground = UIColor(hex: "#DEC16B")
    static let ice = UIColor(hex: "#9AD6DF")
    static let poison = UIColor(hex: "#A43E9E")
    static let psychic = UIColor(hex: "#FB5584")
    static let rock = UIColor(hex: "#B69E31")
    static let steel = UIColor(hex: "#B7B9D0")
    static let water = UIColor(hex: "#6493EB")

    // MARK: - Tons de Cinza
    static let grayDark = UIColor(hex: "#212121")
    static let grayMedium = UIColor(hex: "#666666")
    static let grayLight = UIColor(hex: "#E0E0E0")
    static let grayBackground = UIColor(hex: "#EFEFEF")
    static let white = UIColor(hex: "#FFFFFF")
    
    // MARK: - Cores Tela de Detalhes
    static let detailBackground = UIColor(hex: "#333333")
    static let detailCardBackground = UIColor(hex: "#FFFFFF")
}

// MARK: - Extensão UIColor para Hex - SwiftUX code snippet
extension UIColor {
    convenience init(hex: String) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        // Garante que o código hexadecimal tenha 6 dígitos.
        assert(hexFormatted.count == 6, "Código hexadecimal inválido. Deve conter 6 dígitos.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
