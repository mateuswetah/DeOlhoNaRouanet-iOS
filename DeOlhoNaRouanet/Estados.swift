//
//  Estados.swift
//  DeOlhoNaRouanet
//
//  Created by Mateus Machado Luna on 17/01/17.
//  Copyright © 2017 Grupo: De Olho na Rouanet. All rights reserved.
//

import Foundation

class Estados {
    
    static func getEstados() -> [(nomeExtenso: String, sigla: String)] {
    
        return [
                ("Acre", "AC"),
                ("Alagoas", "AL"),
                ("Amapá", "AP"),
                ("Amazonas", "AM"),
                ("Bahia", "BA"),
                ("Ceará", "CE"),
                ("Distrito Federal", "DF"),
                ("Espírito Santo", "ES"),
                ("Goiás", "GO"),
                ("Maranhão", "MA"),
                ("Mato Grosso", "MT"),
                ("Mato Grosso do Sul", "MS"),
                ("Minas Gerais", "MG"),
                ("Pará", "PA"),
                ("Paraíba", "PB"),
                ("Paraná", "PR"),
                ("Pernambuco", "PE"),
                ("Piauí", "PI"),
                ("Rio de Janeiro", "RJ"),
                ("Rio Grande do Norte", "RN"),
                ("Rio Grande do Sul", "RS"),
                ("Rondônia", "RO"),
                ("Roraima", "RR"),
                ("Santa Catarina", "SC"),
                ("São Paulo", "SP"),
                ("Sergipe", "SE"),
                ("Tocantins", "TO")
                ]
    
    }
    
}